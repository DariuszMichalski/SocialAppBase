class Admin::UsersController < Admin::BaseController

  def index
    @users = Social::User.all
  end

  def show
    @user = Social::User.find_by_id(params[:user_id] || params[:id])
  end

  def toggle_block
    @user = Social::User.find_by_id(params[:user_id] || params[:id])
    @user.blocked? ? @user.unblock! : @user.block!
    flash[:info] = "Settings has been saved"
    redirect_to admin_users_path
  end
end
