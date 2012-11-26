require 'RMagick'

class GMS
  class Stitcher

    attr_accessor :dir, :output_file

    def initialize(dir, output_file="map.png")
      @dir = dir
      @output_file = output_file
    end

    def tiles
      Dir.glob(File.join(dir,"*")).map do |path|
        Dir.glob(File.join(path,"*.png")).map do |image|
          image
        end
      end
    end

    def process
      output = Magick::ImageList.new

      tiles.each do |row|
        column = Magick::ImageList.new
        row.each do |file|
          puts "Combining #{file}"
          column.push(Magick::Image.read(file).first)
        end
        output.push(column.append(true))
      end
      output.append(false).write(@output_file)
    end
  end
end
