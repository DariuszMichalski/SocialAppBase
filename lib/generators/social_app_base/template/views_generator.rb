module SocialAppBase
  module  Generators
    module Template
      class ViewsGenerator < Rails::Generators::Base
        require 'rails/generators/active_record'
        include Rails::Generators::Migration

        source_root File.expand_path('../../../../..', __FILE__)

        def generate_views
          copy_file   'app/views/social/pages/blocked.html.haml'      , 'app/views/social/pages/blocked.html.haml'
          copy_file   'app/views/social/pages/new.html.haml'          , 'app/views/social/pages/new.html.haml'
          copy_file   'app/views/social/pages/time_expired.html.haml' , 'app/views/social/pages/time_expired.html.haml'  
          create_file 'app/views/social/pages/show.html.haml'
        end

      end
    end
  end
end
