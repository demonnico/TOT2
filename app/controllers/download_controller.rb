class DownloadController < ApplicationController

  before_filter :authorize, :only => [:downdsym]

  def index
  end

  def downipa
    version_id = params[:version_id]
    if version_id == nil
      redirect_to '/'
    end
    app_version = AppVersion.find_by_id(version_id)
    ipa_path = app_version.ipa_path
    send_file ipa_path
  end

  def downdsym
    version_id = params[:version_id]
    if version_id == nil
      redirect_to '/'
    end
    app_version = AppVersion.find_by_id(version_id)
    ipa_path = app_version.dsym_path
    send_file ipa_path
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
