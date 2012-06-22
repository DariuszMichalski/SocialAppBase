SocialAppBase.configure do |config|
  YAML.load_file("#{Rails.root}/config/social-app-base.yml")[Rails.env].each do |key,val|
    config.send("#{key}=",val)
  end
end