class UploadController < ApplicationController

	require 'file_system_helper'
	require 'binary_plist_helper'

	layout '_navigation'
	before_filter :authorize, :only => [:upload]

	#############################################################################
	# actions

	def upload
		# save files if ipa POSTed
		if request.request_method == 'POST' # an upload performed with POST method


			# get io from posted params
			uploaded_ipa_io = params[:ipa] # uploaded ipa file handle
			uploaded_dSYM_io = params[:dsym] #uploaded dSYM file handle

			# check file available
			notice_string = "Upload successed."
			alert_string = nil
			if uploaded_ipa_io == nil # ipa is nil, upload failed
				notice_string = nil
				alert_string = "IPA file doesn't exist."
			elsif !ipa_io_type_available?(uploaded_ipa_io) # ipa type error, upload failed
				notice_string = nil
				alert_string = "Please choose an IPA file."
			elsif uploaded_dSYM_io == nil # dsym is nil, upload successed with warning
				notice_string = "IPA upload successed, but it's suggested that to upload a dSYM. You can upload it later in \"Apps\" tab."
				alert_string = nil;
			elsif !dSYM_io_type_available?(uploaded_dSYM_io) # dsym type error, upload failed
				notice_string = nil
				alert_string = "Please choose a zip file as dSYM"
			end

			if alert_string == nil # if file available, handle file to disk
				# save file to disk
				FileSystemHelper.save_io_to_file(uploaded_ipa_io, temp_file_path_for_ipa)

				# find zip path for zip file. e.g. 'Payload/neteasemusic.app/'
				app_path = FileSystemHelper.find_app_path_from_zip_file(temp_file_path_for_ipa)
				if !app_path #if ipa doesn't exist, notice an error and return
					flash[:notice] = nil
					flash[:alert] = 'Invalide IPA file.'
					return
				end

				# unzip Info.plist
				plist_zip_path = app_path + "Info.plist"
				plist_unzip_path =  temp_file_path_for_file_name("Info.plist")
				FileSystemHelper.zip_file_to_destination(temp_file_path_for_ipa, {
					plist_zip_path => plist_unzip_path,
				})

				# get info from Info.plist
				parsed_hash = BinaryPlistHelper.hash_from_plist_file(plist_unzip_path)

				# get bundle id
				bundle_id = BinaryPlistHelper.get_bundle_id(parsed_hash) # bundle id
				if !bundle_id
					flash[:notice] = nil
					flash[:alert] = 'Invalide IPA file.'
					return
				end
				
				# unzip icon files
				unzip_hash = {}

				# Icon file name
				icon_file_name = BinaryPlistHelper.get_icon_file_name(parsed_hash)
				icon_temp_path = temp_file_path_for_file_name("Icon.png")
				icon2x_temp_path = temp_file_path_for_file_name("Icon@2x.png")
				itunes_artwork_temp_path = temp_file_path_for_file_name("iTunesArtwork.png")
				if icon_file_name
					unzip_hash[app_path + icon_file_name] = icon2x_temp_path
				else
					unzip_hash[app_path + "Icon@2x.png"] = icon2x_temp_path
					unzip_hash[app_path + "Icon.png"] = icon_temp_path
				end

				# iTunesArtwork file name
				itunes_artwork_file_name = BinaryPlistHelper.get_itunes_artwork_file_name(parsed_hash)
				unzip_hash[app_path + itunes_artwork_file_name] = itunes_artwork_temp_path

				# unzip icons
				FileSystemHelper.zip_file_to_destination(temp_file_path_for_ipa, unzip_hash)

				# version, short version, bundle id, display_name, change log
				version_string = BinaryPlistHelper.get_version_string(parsed_hash) # version string
				version_string = "unknown" if !version_string
				short_version_string = BinaryPlistHelper.get_short_version_string(parsed_hash) # version short string
				short_version_string = "unknown" if !short_version_string
				display_name = BinaryPlistHelper.get_display_name(parsed_hash) # app display name
				display_name = "unknown" if !display_name
				post_hash = params["app_version"]
				change_log = post_hash["change_log"] if post_hash
				change_log = "This uploader is too lazy to write change log" if (!change_log || change_log.length == 0)

				# query app
				uploaded_app = App.where(:bundle_id => bundle_id).first
				beta_version_string = (uploaded_app ? uploaded_app.last_version + 1 : 1).to_s

				# store icon
				icon_relative_storage_path = nil
				icon_storage_path = nil
				if File.exist?(icon2x_temp_path)
					icon_relative_storage_path = storage_file_relative_path(bundle_id, beta_version_string, "Icon.png").to_s
					icon_storage_path = storage_file_path(bundle_id, beta_version_string, "Icon.png")
					FileSystemHelper.mv_file(icon2x_temp_path, icon_storage_path)
				elsif File.exist?(icon_temp_path)
					icon_relative_storage_path = storage_file_relative_path(bundle_id, beta_version_string, "Icon.png").to_s
					icon_storage_path = storage_file_path(bundle_id, beta_version_string, "Icon.png")
					FileSystemHelper.mv_file(icon_temp_path, icon_storage_path)
				end

				# store iTunesArtwork
				itunes_artwork_relative_storage_path = nil
				itunes_artwork_storage_path = nil
				if File.exist?(itunes_artwork_temp_path)
					itunes_artwork_relative_storage_path = storage_file_relative_path(bundle_id, beta_version_string, "iTunesArtwork.png")
					itunes_artwork_storage_path = storage_file_path(bundle_id, beta_version_string, "iTunesArtwork.png")
					FileSystemHelper.mv_file(itunes_artwork_temp_path, itunes_artwork_storage_path)
				end

				if(!uploaded_app) # if bundle id never uploaded, create a new one
					uploaded_app = App.new(
						:bundle_id => bundle_id,
						:last_version => 0,
					)
					uploaded_app.save
				end

				uploaded_version = AppVersion.new(
						:beta_version => uploaded_app.last_version + 1,
						:app_name => display_name,
						:version => version_string,
						:short_version => short_version_string, 
						:release_date => DateTime.now,
						:change_log => change_log, 
						:ipa_path => "ipa",
						:dsym_path => "dsym",
						:icon_path => icon_relative_storage_path, 
						:itunes_artwork_path => itunes_artwork_relative_storage_path
					)
				uploaded_app.app_versions << uploaded_version
				uploaded_app.last_version += 1
				uploaded_app.save

				@info = uploaded_app.app_versions

				# save dSYM to disk
				if uploaded_dSYM_io
					FileSystemHelper.save_io_to_file(uploaded_dSYM_io, temp_file_path_for_dsym)
				end
			end

			# notice user messages
		    flash[:notice] = notice_string
		    flash[:alert] = alert_string
		    if alert_string == nil # upload successed, redirect to apps page
		    	# redirect_to '/admin'
		    end
		end
	end

	#############################################################################
	# private methods

	private	

	# check access permission
	def authorize
		if current_user == nil || !(can? :manage, @app)
			flash[:notice] = "You don't have permission to access upload page."
			redirect_to '/admin'
			return
		end 
	end

	# check file type
	def ipa_io_type_available?(io)
		if io == nil
			return false
		elsif io.content_type != "application/octet-stream" || File.extname(io.original_filename).downcase != ".ipa"
			return false
		end

		return true
	end

	def dSYM_io_type_available?(io)
		if io == nil
			return false
		elsif io.content_type != "application/zip" || File.extname(io.original_filename).downcase != ".zip"
			return false
		end

		return true
	end

	# gem storage file path
	def storage_file_path(bundle_id, beta_version, file_name)
		ret_path = Rails.root.join(storage_file_relative_path(bundle_id, beta_version, file_name))
		return ret_path
	end

	def storage_file_relative_path(bundle_id, beta_version, file_name)
		ret_path = 'public/uploads/storage/' + bundle_id + '/' + beta_version + '/' + file_name
		return ret_path
	end

	# gen temp file path
	def temp_file_path_for_file_name(file_name)
		ret_path = Rails.root.join('public', 'uploads', 'temp', session[:session_id], file_name)
		return ret_path
	end

	def temp_file_path_for_ipa
		return temp_file_path_for_file_name('temp_ipa.ipa')
	end

	def temp_file_path_for_dsym
		return temp_file_path_for_file_name('temp_dsym.zip')
	end
end
