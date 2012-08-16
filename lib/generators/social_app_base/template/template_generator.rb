module SocialAppBase
  module  Generators
    class TemplateGenerator < Rails::Generators::Base
      require 'rails/generators/active_record'
      include Rails::Generators::Migration

      source_root File.expand_path('../../../../..', __FILE__)

      def generate_initialization
        copy_file 'config/social-app-base.yml', 'config/social-app-base.yml'
      end

      def generate_migration
        destination   = File.expand_path('db/migrate/01_create_template.rb', self.destination_root)
        migration_dir = File.dirname(destination)
        destination   = self.class.migration_exists?(migration_dir, 'create_temaplate')
        
        if destination
          puts "\e[0m\e[31mFound existing create_template.rb migration. Remove it if you want to regenerate.\e[0m"
        else
          migration_template 'db/migrate/01_create_template.rb', 'db/migrate/create_template.rb'
        end
      rescue 
        nil
      end

      def generate_public_assets
        copy_file 'app/assets/stylesheets/social-app-base/jquery-ui/jquery-ui-1.8.17.css' , 'vendor/assets/stylesheets/social-app-base/jquery-ui/jquery-ui-1.8.17.css'
        directory 'app/assets/stylesheets/social-app-base/jquery-ui/images'   , 'app/assets/images/jquery-ui'
        directory 'app/assets/stylesheets/social-app-base/jquery-ui/images'   , 'vendor/assets/stylesheets/social-app-base/jquery-ui/jquery-ui'
        directory 'app/assets/stylesheets/social-app-base/admin'              , 'vendor/assets/stylesheets/social-app-base/admin'
        copy_file 'app/assets/stylesheets/social-app-base/admin.css'          , 'vendor/assets/stylesheets/social-app-base/admin.css'
        copy_file 'app/assets/stylesheets/social-app-base/info.css'           , 'vendor/assets/stylesheets/social-app-base/info.css'
        copy_file 'app/assets/stylesheets/social-app-base/install.css'        , 'vendor/assets/stylesheets/social-app-base/install.css'

        copy_file 'app/assets/javascripts/social-app-base/application.js'     , 'vendor/assets/javascripts/social-app-base/application.js'
        copy_file 'app/assets/javascripts/social-app-base/jquery-1.7.1.js'    , 'vendor/assets/javascripts/social-app-base/jquery-1.7.1.js'
        copy_file 'app/assets/javascripts/social-app-base/jquery-ui-1.8.17.js', 'vendor/assets/javascripts/social-app-base/jquery-ui-1.8.17.js'
        directory 'app/assets/images/social-app-base'                         , 'vendor/assets/images/social-app-base'
      end      

      def generate_locales
        copy_file 'config/locales/en.yml', 'config/locales/en.yml'
        copy_file 'config/locales/pl.yml', 'config/locales/pl.yml'  
      end      

      def self.next_migration_number(dirname)
        ActiveRecord::Generators::Base.next_migration_number(dirname)
      end

    end
  end
end
