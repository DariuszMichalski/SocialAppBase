module SocialAppBase
  module  Generators
    module Template
      class ViewsGenerator < Rails::Generators::Base
        require 'rails/generators/active_record'
        include Rails::Generators::Migration

        source_root File.expand_path('../../../../..', __FILE__)

        def generate_views
          # pages
          copy_file   'app/views/social/pages/blocked.html.haml'      , 'app/views/social/pages/blocked.html.haml'
          copy_file   'app/views/social/pages/new.html.haml'          , 'app/views/social/pages/new.html.haml'
          copy_file   'app/views/social/pages/time_expired.html.haml' , 'app/views/social/pages/time_expired.html.haml'  
          copy_file   'app/views/social/pages/show.html.haml'         , 'app/views/social/pages/show.html.haml'
          # main
          copy_file   'app/views/social/main/blank.html.haml'           , 'app/views/social/main/blank.html.haml'
          copy_file   'app/views/social/main/index.html.haml'           , 'app/views/social/main/index.html.haml'
          copy_file   'app/views/social/main/install.html.haml'         , 'app/views/social/main/install.html.haml'  
          copy_file   'app/views/social/main/like.html.haml'            , 'app/views/social/main/like.html.haml'
          copy_file   'app/views/social/main/not_compatibile.html.haml' , 'app/views/social/main/shonot_compatibilew.html.haml'
        end

      end
    end
  end
end
