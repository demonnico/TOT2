class AppController < ApplicationController

  layout '_distribution'

  def applist
    @applist = App.all
    @back_uri = nil
    @navigation_title = 'Install Apps'
  end

  def version_detail
    version_id = params[:version_id]
    @back_uri = params[:back_uri]
    if version_id == nil
      redirect_to '/'
    end
    @app_version = AppVersion.find_by_id(version_id)
    if !@app_version
      redirect_to '/'
      return
    end

    @navigation_title = 'Install ' + @app_version.app_name
  end

  def more_version
  end
end
