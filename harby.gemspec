spec = Gem::Specification.new do |s|
  s.name         = "harby"
  s.version      = "1.0.0"
  s.authors      = ["Ross Paffett"]
  s.email        = ["ross@rosspaffett.com"]
  s.homepage     = "http://github.com/raws/harby"
  s.summary      = "Simple textual command parser"
  s.description  = "A grammar-based parser for textual commands. Ideal for IRC bots."
  s.files        = Dir["lib/**/*.rb", "lib/**/*.treetop"]
  s.require_path = "lib"
  
  s.required_ruby_version = ">= 1.9.2"
  s.add_dependency "treetop", ">= 1.4.9"
end
