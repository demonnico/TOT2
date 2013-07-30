module BinaryPlistHelper
	require 'cfpropertylist'

	#Class Methods
	class << self 
		def hash_from_plist_file(plist_file_path)
			if !plist_file_path
				return nil
			end

			plist = CFPropertyList::List.new(:file => plist_file_path)
	  		data = CFPropertyList.native_types(plist.value)
	  		return data
		end

		# get icon's zip path from parsed_plist_hash and zip_app_path
		# params: parsed_plist_hash : returned data from `hash_from_plist_file`
		#			   zip_app_path : app path in zip. e.g. 'Payload/neteasemusic.app/'
		# first find hash["CFBundleIconFiles"].lastObject
		# then find hash["CFBundleIcons"]["CFBundlePrimaryIcon"]["CFBundleIconFiles"].lastObject
		# then find hash["CFBundleIconFile"]
		def get_icon_zip_path(parsed_plist_hash, zip_app_path)
			return nil if (!parsed_plist_hash || !zip_app_path)


		end

		# get version string from hash
		def get_version_string(parsed_plist_hash)
			return nil if !parsed_plist_hash
			return parsed_plist_hash["CFBundleVersion"]
		end

		# get short version string from hash
		def get_short_version_string(parsed_plist_hash)
			return nil if !parsed_plist_hash
			return parsed_plist_hash["CFBundleShortVersionString"]
		end

		# get bundle id from hash
		def get_bundle_id(parsed_plist_hash)
			return nil if !parsed_plist_hash
			return parsed_plist_hash["CFBundleIdentifier"]
		end

		# get display name from hash
		def get_display_name(parsed_plist_hash)
			return nil if !parsed_plist_hash
			return parsed_plist_hash["CFBundleDisplayName"]
		end
	end
end
