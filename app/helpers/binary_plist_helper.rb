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
	end
end
