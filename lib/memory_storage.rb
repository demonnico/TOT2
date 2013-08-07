class MemoryStorage
	@@objects = {}

	class << self 
		def get(key)
			@@objects[key]
		end

		def set(key, object)
			@@objects[key] = object
		end

		def get_host_url
			get(:host_url)
		end

		def set_host_url(host_url)
			return if !host_url

			host_url_status = get(:host_url_status)
			if !host_url_status
				set(:host_url, host_url)
				if host_url.match(/^localhost/) || host_url.match(/^0.0.0.0/) || host_url.match(/^127.0.0.1/)
					set(:host_url_status, 1)
				else
					set(:host_url_status, 2)
				end
				return
			elsif host_url_status == 1
				if host_url.match(/^localhost/) || host_url.match(/^0.0.0.0/) || host_url.match(/^127.0.0.1/)
					return
				else
					set(:host_url, host_url)
					set(:host_url_status, 2)
				end
				return
			elsif host_url_status == 2
				return
			end

		end
	end
end
