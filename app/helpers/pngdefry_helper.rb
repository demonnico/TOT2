module PngdefryHelper
  class << self
    def defry_png(source_path = '')
      pngdefry_path = Rails.root.join('lib', 'myplugin', 'pngdefry', 'pngdefry').to_s
      source_dir = File.dirname(source_path)
      command_string = pngdefry_path + ' -o\'' + source_dir + '\' \'' + source_path + '\''
      system(command_string)

      # Rails.logger.info("pngcrush executed: " + command_string)
    end
  end
end
