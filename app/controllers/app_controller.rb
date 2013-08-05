class AppController < ApplicationController

  require 'manifest_helper'

  layout '_distribution'

  def applist
    @applist = App.all
    @back_uri = nil
    @navigation_title = 'Install Apps'
  end

  def version_detail
    version_id = params[:version_id]
    @back_uri = params[:back_uri] || '/'
    if version_id == nil
      redirect_to '/'
    end
    @app_version = AppVersion.find_by_id(version_id)
    if !@app_version
      @navigation_title = 'Version Not Found'
    else
      @navigation_title = 'Install ' + @app_version.app_name
    end
  end

  def more_version
    app_id = params[:app_id]
    @back_uri = params[:back_uri] || '/'
    if app_id == nil
      redirect_to '/'
    end
    @app = App.find_by_id(app_id)
    if !@app
      @navigation_title = 'App Not Found'
    else
      @versions = @app.app_versions.reverse
      if @versions.empty?
        @navigation_title = 'No Version Found'
      else
        @navigation_title = @app.bundle_id    
      end
    end
  end

  def get_manifest
    version_id = params[:version_id]
    if version_id == nil
      send_data(nil)
    end
    app_version = AppVersion.find_by_id(version_id)
    if app_version
      manifest_data = ManifestHelper.gen_manifest(app_version)
      send_data(manifest_data, :filename=>'manifest.plist')
    end
  end
end
