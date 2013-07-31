class AppVersion < ActiveRecord::Base
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
					:itunes_artwork_path

end
