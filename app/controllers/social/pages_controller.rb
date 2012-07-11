class Social::PagesController < Social::BaseController
  # For actions which require facebook fan page #
  before_filter :render_blank_and_return_if_not_page, :only => ["show", "new"]
  # ------------------------------------------- #
  before_filter :check_if_fan_page_loaded
  before_filter :load_page, :except => ["new", "create"]
  before_filter :check_fan_gate, :only => ["show"]
  before_filter :admin_rights, :except => ["show"]

  def show
    # zabezpieczenie jezeli dostep do strony zostal
    # wylaczony lub wygasl okres dostepu ------------- #
    if @page.blocked?
      render (admin? ? "blocked" : "main/blank")
      return
    end
    if @page.access_time_expired?
      render (admin? ? "time_expired" : "main/blank")
      return
    end
    # ------------------------------------------------ #
  end

  def new
    @page = Social::Page.new()
  end

  def create
    begin
      @user = Social::User.find_by_facebook_uid(fb_session.user_id) if fb_session and fb_session.user_id.present?
      @page = @user ? @user.pages.new(params[:social_page]) : (user_signed_in? ? current_user.pages.new(params[:social_page]) : Social::Page.new(params[:social_page]))
      @page.page_id = fb_session.page_id
    rescue Exception => e
      new_log = SystemLog.new(:resource_type => "Page", :resource_id => nil, :action => "registering new page", :exception => e.to_s, :hashed_object => @page )
      new_log.save
    end
    if @page.save
      redirect_to social_page_path(:id=>@page.fb_id)
    else
      render :new
    end
  end

  def update
    respond_to do |format|
      format.js {
        if params[:social_page][:fan_gate]
          @page.fan_gate = params[:social_page][:fan_gate]
        end
        @page.save!
      }
    end
  end

  private

  def check_fan_gate
    check_page_like if @page.fan_gate
  end
end
