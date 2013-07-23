class AdminController < ApplicationController
	def apps
	end

	def users
	end

	def upload
		if current_user == nil || !(can? :manage, @app)
			redirect_to '/admin'
		end
			
		if request.request_method == 'POST' # an upload performed

			#save ipa to disk
			uploaded_ipa_io = params[:ipa] # uploaded ipa file handle
			if uploaded_ipa_io != nil # if ipa exist, save it to local storage
				uploaded_ipa_name = Rails.root.join('public', 'uploads', uploaded_ipa_io.original_filename)
				File.open(uploaded_ipa_name, 'wb+') do |file|
					file.write(uploaded_ipa_io.read)
				end
			else #if ipa doesn't exist, make an error to user
			end

			#save dSYM to disk
			uploaded_dsym_io = params[:dsym] #uploaded dSYM file handle
			if uploaded_dsym_io != nil #if dSYM exist, save it to local storage
				uploaded_dsym_name = Rails.root.join('public', 'uploads', uploaded_dsym_io.original_filename)
				File.open(uploaded_dsym_name, 'wb+') do |file|
					file.write(uploaded_dsym_io.read)
				end
			else #if dSYM doesn't exist, make an warning to user
			end
		end
	end
end
