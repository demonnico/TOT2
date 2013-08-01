class AppVersion < ActiveRecord::Base

  require 'file_system_helper'

  before_destroy  :delete_files
  after_destroy   :check_if_need_delete_app

  belongs_to :app

  attr_accessible :beta_version,
          :app_name,
          :version,
          :short_version, 
          :release_date,
          :change_log, 
          :ipa_path,
          :dsym_path,
          :icon_path, 
          :itunes_artwork_path,
          :uploader_email

  def delete_files
    bundle_id = app.bundle_id
    FileSystemHelper.rm_file(ipa_path)
    FileSystemHelper.rm_file(dsym_path)
    FileSystemHelper.rm_file(icon_path)
    FileSystemHelper.rm_file(itunes_artwork_path)
    FileSystemHelper.rm_file(FileSystemHelper.storage_path(bundle_id, beta_version.to_s))
  end

  def check_if_need_delete_app
    app.destroy if app.app_versions.count == 0
  end

end
