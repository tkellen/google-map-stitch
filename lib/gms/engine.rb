class GMS
  class Engine

    attr_accessor :startX, :endX, :startY, :endY, :zoomLevel, :layer

    def initialize(config)

      @zoomLevel = config[:zoomLevel]||2

      # two is the minimum zoom level
      @zoomLevel = 2 if config[:zoomLevel] < 2

      # if all starting and ending coords are not defined, then
      # assume we want the whole map
      if ![:startX,:endX,:startY,:endY].all? { |key| config.has_key?(key) }
        @startX = 0
        @endX = 2**config[:zoomLevel]-1
        @startY = 0
        @endY = 2**config[:zoomLevel]-1
      else
        @startX = config[:startX]
        @endX = config[:endX]
        @startY = config[:startY]
        @endY = config[:endY]
      end

      # allow the downloaded layer to be customized
      @layer = config[:layerID] || "m@195000000"

      status
    end

    # total width in tiles
    def width
      @endX-@startX
    end

    # total height in tiles
    def height
      @endY-@startY
    end

    # total width in pixels
    def pixelWidth
      width*256
    end

    # total height in pixels
    def pixelHeight
      width*256
    end

    # total width printed @ 300 dpi (in inches)
    def printWidth(dpi=300)
      (pixelWidth.to_f/dpi).round(2)
    end

    # total height printed @ 300 dpi (in inches)
    def printHeight(dpi=300)
      (pixelHeight.to_f/dpi).round(2)
    end

    # total number of tiles to download
    def tileCount
      width*height
    end

    # build a url for a google image
    def imageURL(x, y, z, layer=@layer)
      "http://mt1.google.com/vt/lyrs=#{layer}&hl=en&x=#{x}&s=&y=#{y}&z=#{z.to_s}"
    end

    def status
      puts "\Google Map Stitch Configuration"
      puts "======================================================="
      puts "Starting Coord: #{@startX},#{@endX}"
      puts "Ending Coord: #{@startY},#{@endY}"
      puts "Zoom Level: #{@zoomLevel}"
      puts "Total Tiles to Download: #{tileCount.to_s.reverse.gsub(/...(?=.)/,'\&,').reverse}"
      puts "Final Image Size @ 72DPI #{pixelWidth}x#{pixelHeight}"
      puts "Final Print Size @ 300DPI (Inches): #{printWidth}\"x#{printHeight}\""
      puts "Final Print Size @ 300DPI (Feet): #{(printWidth/12).round(2)}'x#{(printHeight/12).round(2)}'"
      puts "=======================================================\n\n"
    end

    # list all tiles
    def tiles
      @startY.upto(@endY).map.with_index do |x, c|
        @startX.upto(@endX).map.with_index do |y, r|
          {
            :url => imageURL(x,y,@zoomLevel,@layer),
            :dir => "r#{"%06d" % r}",
            :file => "c#{"%06d" % c}.png"
          }
        end
      end.flatten
    end
  end
end
