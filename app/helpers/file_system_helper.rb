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

		def save_io_to_file(io, file_path)
			File.open(file_path, 'wb+') do |file|
				file.write(io.read)
			end
		end
	end

end
