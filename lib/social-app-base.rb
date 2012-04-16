unless defined? ComfortableMexicanSofa::Application
  require File.expand_path("social-app-base/engine", File.dirname(__FILE__))
end

[ 'social-app-base/facebook/facebook_authentication',
  'social-app-base/facebook/facebook_session',
  'social-app-base/renderers',
  'social-app-base/configuration'
].each do |path|
  require File.expand_path(path, File.dirname(__FILE__))
end

module SocialAppBase
  class << self
    
    def configure
      yield configuration
    end
    
    # Accessor for ComfortableMexicanSofa::Configuration
    def configuration
      @configuration ||= Configuration.new
    end
    alias :config :configuration

  end
end
