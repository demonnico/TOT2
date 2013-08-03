class DownloadController < ApplicationController

  before_filter :authorize, :only => [:downdsym]

  def index
  end

  def downimage
    version_id = params[:version_id]
    if version_id == nil
      send_data(nil, :filename=>'icon.png', :type=>'image/png', :disposition => "inline")
    end
    app_version = AppVersion.find_by_id(version_id)
    if !app_version
      send_data(nil, :filename=>'icon.png', :type=>'image/png', :disposition => "inline")
    else
      icon_path = app_version.thumb_path
      data=File.new(icon_path, "rb").read
      send_data(data, :filename=>'icon.png', :type=>'image/png', :disposition => "inline")  
    end
  end

  def downipa
    version_id = params[:version_id]
    if version_id == nil
      redirect_to '/'
    end
    app_version = AppVersion.find_by_id(version_id)
    ipa_path = app_version.ipa_path
    send_file ipa_path, filename: app_version.app_name + app_version.version + '_#' + app_version.beta_version.to_s + '.ipa'
  end

  def downdsym
    version_id = params[:version_id]
    if version_id == nil
      redirect_to '/'
    end
    app_version = AppVersion.find_by_id(version_id)
    dsym_path = app_version.dsym_path
    send_file dsym_path, filename: app_version.app_name + app_version.version + '_#' + app_version.beta_version.to_s + '_dSYM.zip'
  end

  def authorize
    if current_user == nil
      redirect_to '/users/sign_in'
    elsif !(can? :manage, App)
      flash[:notice] = "You don't have permission to download dsym"
      redirect_to '/admin'
      return
    end 
  end
end
