require 'open-uri'

class GMS
  class Downloader

    attr_accessor :files, :output_dir

    def initialize(files, output_dir="tiles")
      @output_dir = output_dir
      @files = files
    end

    def mkdir?(dir)
      Dir.mkdir(dir) if !Dir.exists?(dir)
    end

    def process
      mkdir?(@output_dir)
      @files.each do |tile|
        mkdir?(File.join(@output_dir,tile[:dir]))
        File.open(File.join(@output_dir,tile[:dir],tile[:file]), 'w+') do |file|
          open(tile[:url], 'rb') do |image|
            file.write(image.read)
          end
        end
      end
    end

  end
end
