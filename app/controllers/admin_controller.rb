class AdminController < ApplicationController
	def apps
	end

	def users
	end

	def upload
		if request.request_method == 'POST'
			uploaded_io = params[:ipa]
			File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'w') do |file|
				file.write(uploaded_io.read)
			end
		end
	end
end
