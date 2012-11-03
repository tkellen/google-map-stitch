require File.expand_path('../lib/google-map-stitch/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = 'google-map-stitch'
  gem.version       = GMS::VERSION
  gem.summary       = 'Download and stitch google map tiles into a single image.'
  gem.description   = gem.description
  gem.author        = 'Tyler Kellen'
  gem.email         = 'tyler@sleekcode.net'
  gem.homepage      = 'https://github.com/tkellen/google-map-stitch/'
  gem.files         = `git ls-files`.split("\n")
  gem.require_paths = ['lib']
  gem.add_runtime_dependency 'rmagick'
end
