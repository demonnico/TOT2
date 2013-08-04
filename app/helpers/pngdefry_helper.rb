module PngdefryHelper
  class << self
    def defry_png(source_path = '')
      pngdefry_path = Rails.root.join('lib', 'myplugin', 'pngdefry', 'pngdefry').to_s
      source_dir = File.dirname(source_path)
      system(pngdefry_path + ' -o\'' + source_dir + '\' ' + source_path)
    end
  end
end
