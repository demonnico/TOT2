class AdminController < ApplicationController

	layout '_navigation'
	before_filter :authorize, :only => [:apps]

	def apps
	end

	#############################################################################
	# private methods

	private	

	# check access permission
	def authorize
		if current_user == nil
			redirect_to '/users/sign_in'
			return
		end 
	end
end
