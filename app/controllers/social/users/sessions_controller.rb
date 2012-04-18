class Social::Users::SessionsController < Devise::SessionsController 
  
  layout "layouts/admin/admin"

  helper_method :backend?

  def backend?
    true
  end

end