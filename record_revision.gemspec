$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "record_revision/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "record_revision"
  s.version     = RecordRevision::VERSION
  s.authors     = ["ponpocopocopon"]
  s.email       = [""]
  s.homepage    = ""
  s.summary     = "record the difference information."
  s.description = "this plugin can automatically record the difference information to data table."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  #s.add_dependency "rails", "~> 4.0.0"
  #s.add_development_dependency "sqlite3"
end
