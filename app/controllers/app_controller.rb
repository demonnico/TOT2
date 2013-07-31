class AppController < ApplicationController

	layout '_navigation'
	before_filter :view_authorize, :only => [:apps]
	before_filter :authorize, :only => [:deleteapp]

	def apps
		@apps = App.all
	end

	def deleteapp
		appId = params[:app_id]
		app = App.find(appId)
		if app
			app.destroy
		end

		redirect_to '/admin/apps'
	end

	#############################################################################
	# private methods

	private	

	# check access permission
	def view_authorize
		if current_user == nil
			redirect_to '/users/sign_in'
		end
	end

	def authorize
		if current_user == nil
			redirect_to '/users/sign_in'
		elsif !(can? :manage, @app)
			flash[:notice] = "You don't have permission to manage app"
			redirect_to '/admin'
			return
		end 
	end
end
