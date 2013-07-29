module FileSystemHelper

	require 'zip/zip'

	#Class Methods
	class << self 
		# helper method, create dir if it doesn't exist
		def make_dir_at_path(string)
			dir = File.dirname(string)

			unless File.directory?(dir)
				FileUtils.mkdir_p(dir)
			end
		end

		#helper method, save io to file
		def save_io_to_file(io, file_path)

			if io == nil || file_path == nil
				return
			end

			make_dir_at_path(file_path)

			File.open(file_path, 'wb+') do |file|
				file.write(io.read)
			end
		end

		# find zip/Payload/*.app/ from zip file
		def find_app_path_from_zip_file(zip_file_path)
			first_file_name = Zip::ZipFile.open(zip_file_path).first.name
			matched_name = /Payload\/\w+\.app\//.match(first_file_name)
			return matched_name
		end

		# helper method, zip a zipfile's subfile to destination path
		# params:
		# 	zip_file_path : file to unzip
		# 	unzip_path_hash : a hash contains unzip info.
		# 		e.g. : unzip zip/a to /tmp/a and unzip zip/b to /tmp/b, pass {"zip/a":"/tmp/a", "zip/b":"tmp/b"}
		def zip_file_to_destination(zip_file_path, unzip_path_hash)
			Zip::ZipFile.open(zip_file_path) do |zipfile|
			end
		end
	end

end
