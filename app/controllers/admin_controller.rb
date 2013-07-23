class AdminController < ApplicationController
	def apps
	end

	def users
	end

	def upload
		if current_user == nil || !(can? :manage, @app)
			redirect_to '/admin'
		end
			
		if request.request_method == 'POST'
			uploaded_ipa_io = params[:ipa]
			uploaded_ipa_name = Rails.root.join('public', 'uploads', uploaded_ipa_io.original_filename)

			File.open(uploaded_ipa_name, 'wb+') do |file|
				file.write(uploaded_ipa_io.read)
			end
		end
	end
end
