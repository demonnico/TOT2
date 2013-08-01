class App < ActiveRecord::Base

  require 'file_system_helper'

  before_destroy :delete_files

  has_many :app_versions, dependent: :destroy
  attr_accessible :bundle_id, :last_version

  def delete_files
    FileSystemHelper.rm_file(FileSystemHelper.storage_path(bundle_id))
  end
end
