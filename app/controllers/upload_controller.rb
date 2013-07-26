class UploadController < ApplicationController

	require 'zip/zip'
	require 'file_system_helper'

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

			# if file available, save to disk
			if alert_string == nil
				FileSystemHelper.save_io_to_file(uploaded_ipa_io, temp_file_path_for_ipa)
				Zip::ZipFile.open(temp_file_path_for_ipa) do |zipfile|
				end
				if uploaded_dSYM_io
					FileSystemHelper.save_io_to_file(uploaded_dSYM_io, temp_file_path_for_dsym)
				end
			end

			# notice user messages
		    flash[:notice] = notice_string
		    flash[:alert] = alert_string
		    if alert_string == nil # upload successed, redirect to apps page
		    	redirect_to '/admin'
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

	def ipa_io_type_available?(io)
		if io == nil
			return false
		elsif io.content_type != "application/octet-stream"
			return false
		end

		return true
	end

	def dSYM_io_type_available?(io)
		if io == nil
			return false
		elsif io.content_type != "application/zip"
			return false
		end

		return true
	end

	def temp_file_path_for_ipa
		uploaded_ipa_name = Rails.root.join('public', 'uploads', session[:session_id], 'temp_ipa.ipa')
		return uploaded_ipa_name
	end

	def temp_file_path_for_dsym
		uploaded_dsym_name = Rails.root.join('public', 'uploads', session[:session_id], 'temp_dsym.zip')
		return uploaded_dsym_name
	end
end
