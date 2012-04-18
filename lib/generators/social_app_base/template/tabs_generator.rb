module SocialAppBase
  module  Generators
    module Template
      class TabsGenerator < Rails::Generators::Base
        require 'rails/generators/active_record'
        include Rails::Generators::Migration

        source_root File.expand_path('../../../../..', __FILE__)

        def generate_tabs
          copy_file 'app/views/social/pages/show.html.haml'             , 'app/views/social/pages/show.html.haml'
          copy_file 'app/views/social/pages/_controls.html.haml'        , 'app/views/social/pages/_controls.html.haml'
          copy_file 'app/views/social/pages/_display_settings.html.haml', 'app/views/social/pages/_display_settings.html.haml'          
          copy_file 'app/views/social/pages/_info.html.haml'            , 'app/views/social/pages/_info.html.haml'
          copy_file 'app/views/social/pages/update.js.erb'              , 'app/views/social/pages/update.js.erb'
        end

      end
    end
  end
end
