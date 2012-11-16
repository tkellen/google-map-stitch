# google-map-stitch

Download and stitch google map tiles into a single image.

## Setup

```console
gem install google-map-stitch
```

## Usage

### Define a section of map and zoom level
```ruby
require 'google-map-stitch'

# entire map
engine = GMS::Engine.new({:zoomLevel=>2})

# subsection (South America)
engine = GMS::Engine.new({
  :startX => 16,
  :endX => 27,
  :startY => 29,
  :endY => 45,
  :zoomLevel => 6
})

# subsection (Mexico)
engine = GMS::Engine.new({
  :startX => 10,
  :endX => 19,
  :startY => 25,
  :endY => 31,
  :zoomLevel => 6
})

```

### Download Tiles
```ruby
downloader = GMS::Downloader.new(engine.tiles, 'tiles_folder')
downloader.process
```

### Combine Tiles
```ruby
stitcher = GMS::Stitcher.new('tiles_folder', 'map.png')
stitcher.process
```

> Copyright (c) 2012 Tyler Kellen. See LICENSE for further details.
