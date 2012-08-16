class Admin::UsersController < Admin::BaseController

  def index
    @users = User.all
  end

  def show
    @user = User.find_by_id(params[:user_id] || params[:id])
  end

  def toggle_block
    @user = User.find_by_id(params[:user_id] || params[:id])
    if @user.admin?
      flash[:info] = "Admin can not be blocked"
    else
      @user.blocked? ? @user.unblock! : @user.block!
      flash[:info] = "Settings has been saved"
    end
    redirect_to admin_users_path
  end
end
