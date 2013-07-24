class UserController < ApplicationController

	layout '_navigation'

	def users
		if current_user == nil || !(can? :manage, @user)
			flash[:notice] = "You don't have permission to access users page."
			redirect_to '/admin'
			return
		end

		@users = User.all
	end
end
