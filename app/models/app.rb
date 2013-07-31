class App < ActiveRecord::Base
	has_many :app_versions, dependent: :destroy
  attr_accessible :bundle_id, :last_version
end
