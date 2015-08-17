spec = Gem::Specification.new do |s|
  s.name = 'harby'
  s.version = '1.1.0'
  s.authors  = ['Ross Paffett']
  s.email  = ['ross@rosspaffett.com']
  s.homepage = 'http://github.com/raws/harby'
  s.summary = 'Parser for a Tcl-like syntax.'
  s.description = 'Parser for a Tcl-like syntax. Ideal for IRC bots.'
  s.license = 'MIT'
  s.files = Dir['lib/**/*.rb', 'lib/**/*.treetop']
  s.require_path = 'lib'

  s.add_dependency 'treetop', '~> 1.6', '>= 1.6.3'
  s.add_development_dependency 'rspec', '~> 3.3'
end
