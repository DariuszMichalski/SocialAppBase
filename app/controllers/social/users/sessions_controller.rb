class Social::Users::SessionsController < Devise::SessionsController 
  
  layout "layouts/admin/admin"

  helper_method :backend?

  rescue_from BCrypt::Errors::InvalidHash, :with => :handle_admin_user_exceptions

  def backend?
    true
  end

  private

  def handle_admin_user_exceptions
    flash[:error] = "You probably wanted to login as a user signed in via Facebook. Use user account registered with the form."
    redirect_to new_user_session_path
  end
end