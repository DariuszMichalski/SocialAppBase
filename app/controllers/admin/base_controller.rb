class Admin::BaseController < ApplicationController
  protect_from_forgery

  before_filter :authenticate_user!
  layout 'admin/admin'

  helper_method :backend?

  def jump # admin root_path
    redirect_to admin_pages_path
  end

  def backend? # checks if user is in backend or not
    true
  end

  private

  def load_user
    @user = Social::User.find_by_id(params[:user_id])
  rescue
    render :text => "User not found"
  end

  def authenticate_user!
    redirect_to new_user_session_path if !user_signed_in? or current_user.role != 'admin'
  end
end
