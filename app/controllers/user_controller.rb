class UserController < ApplicationController

	layout '_navigation'
	before_filter :authorize, :only => [:users]

	def users
		@users = User.all
	end

	# warning : when deleting users check whether it is self.

	#############################################################################
	# private methods

	private	

	# check access permission
	def authorize
		if current_user == nil || !(can? :manage, @user)
			flash[:notice] = "You don't have permission to access users page."
			redirect_to '/admin'
			return
		end
	end
end
