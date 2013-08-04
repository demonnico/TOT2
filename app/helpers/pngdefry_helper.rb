module PngdefryHelper
  class << self
    def defry_png(source_path = '')
      if !File.exist?(source_path)
        return
      end

      pngdefry_path = Rails.root.join('lib', 'myplugin', 'pngdefry', 'pngdefry').to_s
      source_dir = File.dirname(source_path)
      command_string = pngdefry_path + ' -o\'' + source_dir + '\' \'' + source_path + '\''
      return_value = system(command_string)

      # Rails.logger.info("pngcrush executed: " + command_string + ' return value:' + return_value.to_s)
    end
  end
end
