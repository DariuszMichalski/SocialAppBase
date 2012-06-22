module SocialAppBase
  module  Generators
    module Template
      class LayoutsGenerator < Rails::Generators::Base
        require 'rails/generators/active_record'
        include Rails::Generators::Migration

        source_root File.expand_path('../../../../..', __FILE__)

        def generate_layouts
          copy_file 'app/views/layouts/social/_flash.html.haml'     , 'app/views/layouts/social/_flash.html.haml'
          copy_file 'app/views/layouts/social/application.html.haml', 'app/views/layouts/social/application.html.haml'
          copy_file 'app/views/layouts/social/info.html.haml'       , 'app/views/layouts/social/info.html.haml'
          copy_file 'app/views/layouts/social/install.html.haml'    , 'app/views/layouts/social/install.html.haml'
        end
      end
    end
  end
end
