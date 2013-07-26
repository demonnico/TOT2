module FileSystemHelper

	#Class Methods
	class << self 
		# helper method, create dir if it doesn't exist
		def make_dir_at_path(string)
			dir = File.dirname(string)

			unless File.directory?(dir)
				FileUtils.mkdir_p(dir)
			end
		end
	end
	
end
