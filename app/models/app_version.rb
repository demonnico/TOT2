class AppVersion < ActiveRecord::Base
	belongs_to :post
	attr_accessible :app_name, :beta_version, :change_log, :icon_url, :release_date, :short_version, :version
end
