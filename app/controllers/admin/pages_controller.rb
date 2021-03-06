class Admin::PagesController < Admin::BaseController
  before_filter :load_user
  before_filter :load_page, :only => [:edit, :update, :update_settings, :toggle_block, :show]

  def index
    @pages = @user ? @user.pages : Social::Page.all
  end

  def show
    render :layout => "social/application"
  end

  def edit
    @page_settings = Admin::PageSettings.new(@page.settings.all)
  end

  def update
    if @page.update_attributes(params[:social_page])
      flash[:info] = "Page has been updated"
      redirect_to edit_admin_page_path(@page)
    else
      flash[:error] = "Error occurred while updating the Page"
      render :edit
    end
  end

  def update_settings
    settings = Admin::PageSettings.new(params[:page_settings]) if params[:page_settings]
    if settings
      @page.settings.time_limit = settings.time_limit
      @page.settings.end_date = settings.end_date
      flash[:info] = "Settings updated"
    else
      flash[:error] = "Could not load page settings"
    end
    redirect_to edit_admin_page_path(@page)
  end

  def toggle_block
    @page.page_blocked? ? @page.unblock! : @page.block!
    flash[:info] = "Settings has been changed"
    redirect_to admin_pages_path(:user_id => @user ? @user.id : nil)
  end

  private

  def load_page
    @page = @user ? @user.pages.find_by_id(params[:page_id] || params[:id]) : Social::Page.find_by_id(params[:page_id] || params[:id])
  end
end
