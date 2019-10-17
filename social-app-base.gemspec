$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "social-app-base/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "social-app-base"
  s.version     = '0.0.2'#SocialAppBase::VERSION
  s.authors     = ["Dariusz Michalski"]
  s.email       = ["dariusz.michalski@useo.pl"]
  s.homepage    = ""
  s.summary     = "Facebook App Template"
  s.description = "Facebook App Template"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.2"
  s.add_dependency "devise", "~> 2.0.4"
  s.add_dependency "haml", "~> 3.1.4"
  s.add_dependency "haml-rails", "~> 0.3.4"
  s.add_dependency "formtastic", "~> 2.1.1"
  s.add_dependency 'paperclip', ">= 2.4", "< 7.0"
  s.add_dependency "omniauth-facebook", "~> 1.2.0"
  s.add_dependency "fb_graph", "~> 2.4.7"
  s.add_dependency 'ledermann-rails-settings'#, :require => 'rails-settings'
  s.add_dependency 'sass-rails',   '~> 3.2.5'
  s.add_dependency 'execjs'
  s.add_dependency "therubyracer" # node.js error fix

  s.add_development_dependency "sqlite3"
end
