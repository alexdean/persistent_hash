$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "persistent_hash/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "persistent_hash"
  s.version     = PersistentHash::VERSION
  s.authors     = ["Alex Dean"]
  s.email       = ["alex@crackpot.org"]
  s.homepage    = "https://github.com/alexdean/persistent_hash"
  s.summary     = "ActiveRecord-based key/value store for Rails applications."
  s.description = "Handy place to stick small bits of persistent data. Like redis if you don't want to install redis."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.1"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "timecop"

end
