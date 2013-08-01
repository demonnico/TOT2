class AppController < ApplicationController

	layout '_navigation'
	before_filter :view_authorize, :only => [:apps, :versions]
	before_filter :authorize, :only => [:deleteapp]

	def apps
		@apps = App.all
	end

	def deleteapp
		appId = params[:app_id]
		app = App.find_by_id(appId)
		if app
			flash[:notice] = app.bundle_id + ' deleted.'
			app.destroy
		else
			flash[:alert] = 'No app found with id: ' + appId
		end

		redirect_to '/admin/apps'
	end

	def versions
		appId = params[:app_id]
		@app = App.find_by_id(appId)
		if !@app
			flash[:alert] = 'No app found with id: ' + appId
			redirect_to '/admin/apps'
			return
		end
		@versions = @app.app_versions.reverse
	end

	#############################################################################
	# private methods

	private	

	# check access permission
	def view_authorize
		if current_user == nil
			redirect_to '/users/sign_in'
		elsif !(can? :read, App)
			flash[:notice] = "You don't have permission to view apps"
			redirect_to '/'
			return
		end
	end

	def authorize
		if current_user == nil
			redirect_to '/users/sign_in'
		elsif !(can? :manage, App)
			flash[:notice] = "You don't have permission to manage apps"
			redirect_to '/admin'
			return
		end 
	end
end
