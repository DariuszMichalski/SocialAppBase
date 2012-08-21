# encoding: utf-8

class SocialAppBase::Configuration
  
  attr_accessor :app_id
  attr_accessor :app_secret
  attr_accessor :office_mail_address
  attr_accessor :mailer_sender
  attr_accessor :facebook_permissions

  # Configuration defaults
  def initialize
    @app_id               = nil
    @app_secret           = nil
    @office_mail_address  = nil
    @mailer_sender        = nil
    @facebook_permissions = ''
  end
  
end