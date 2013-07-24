class UserController < ApplicationController

	layout '_navigation'

	def users
		@users = User.all
	end
end
