class App < ActiveRecord::Base
	has_many :app_versions
  attr_accessible :bundle_id, :last_version
end
