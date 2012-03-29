$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "social-app-base/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "social-app-base"
  s.version     = SocialAppBase::VERSION
  s.authors     = ["Dariusz Michalski"]
  s.email       = ["dariusz.michalski@useo.pl"]
  s.homepage    = ""
  s.summary     = "Facebook App Template"
  s.description = "Facebook App Template"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.2"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
