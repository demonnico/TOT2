class ApplicationController < ActionController::Base

	# redirect of devise login
	def after_sign_in_path_for(resource)
		"/admin"
	end

	# redirect of devise logout
	def after_sign_out_path_for(resource_or_scope)
		#request.referrer #Keeping user on the same page after signing out
		"/admin"
	end

	def not_found
	  	raise ActionController::RoutingError.new('Not Found')
	end
end
