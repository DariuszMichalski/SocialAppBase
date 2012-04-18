module SocialAppBase
  module  Generators
    class TemplateGenerator < Rails::Generators::Base
      require 'rails/generators/active_record'
      include Rails::Generators::Migration

      source_root File.expand_path('../../../../..', __FILE__)

      def generate_initialization
        copy_file 'config/initializers/social-app-base.rb',
          'config/initializers/social-app-base.rb'
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
        directory 'app/assets/stylesheets/social-app-base',
          'public/stylesheets/social-app-base'
        directory 'app/assets/javascripts/social-app-base',
          'public/javascripts/social-app-base'
        directory 'app/assets/images/social-app-base',
          'public/images/social-app-base'
      end      

      def generate_locales
        copy_file 'config/locales/en.yml',
          'config/locales/en.yml'
        copy_file 'config/locales/pl.yml',
          'config/locales/pl.yml'  
      end      

      def self.next_migration_number(dirname)
        ActiveRecord::Generators::Base.next_migration_number(dirname)
      end

    end
  end
end
