SocialAppBase.configure do |config|
  if File.exists?("#{Rails.root}/config/social-app-base.yml")
    YAML.load_file("#{Rails.root}/config/social-app-base.yml")[Rails.env].each do |key,val|
      config.send("#{key}=",val)
    end
  end
end