module SocialAppBase
  module  Generators
    module Template
      class TabsGenerator < Rails::Generators::Base
        require 'rails/generators/active_record'
        include Rails::Generators::Migration

        source_root File.expand_path('../../../../..', __FILE__)

        def generate_layouts
          copy_file 'app/views/layouts/admin/_login_info.html.haml',
            'app/views/layouts/admin/_login_info.html.haml'
          copy_file 'app/views/layouts/admin/_menu.html.haml',
            'app/views/layouts/admin/_menu.html.haml'
          copy_file 'app/views/layouts/_flash.html.haml',
            'app/views/layouts/_flash.html.haml'
          copy_file 'app/views/layouts/admin.html.haml',
            'app/views/layouts/admin.html.haml'
          copy_file 'app/views/layouts/application.html.haml',
            'app/views/layouts/application.html.haml'
          copy_file 'app/views/layouts/info.html.haml',
            'app/views/layouts/info.html.haml'
          copy_file 'app/views/layouts/install.html.haml',
            'app/views/layouts/install.html.haml'
        end
      end
    end
  end
end
