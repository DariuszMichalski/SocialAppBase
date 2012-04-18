class Social::Users::SessionsController < Devise::SessionsController 
  
  layout "/layouts/admin"

  helper_method :backend?

  def backend?
    true
  end

end