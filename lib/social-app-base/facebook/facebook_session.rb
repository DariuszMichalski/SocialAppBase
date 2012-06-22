module FacebookSession
  @fb_session = nil

  # decode facebook signed_request
  def set_facebook_session(signed_request)
      hashed_signed_request = FacebookAuthentication::parse_signed_request(signed_request, SocialAppBase.config.app_secret)
      session[:fb] = hashed_signed_request
  end
  # manage facebook session
  def clear_fb_session
    session[:fb] = nil
    redirect_to root_path
  end
  def fb_session
    @fb_session ||= FBSession.new(session[:fb])
  end
  def fb_session?
    session[:fb] ? true : false
  end
  def admin?
    (fb_session && fb_session.admin?) ? true : false
  end
end

class FBSession
  attr_accessor :expires, :issued_at, :oauth_token, :page_id, :liked, :admin, :user_id, :locale

  def initialize(signed_request)
    if signed_request
      @expires      = signed_request["expires"]
      @issued_at    = signed_request["issued_at"]
      @oauth_token  = signed_request["oauth_token"]
      @user_id      = signed_request["user_id"]
      if signed_request["page"]
        @page_id      = signed_request["page"]["id"]
        @liked        = signed_request["page"]["liked"]
        @admin        = signed_request["page"]["admin"]
      end
      @locale = signed_request["user"]["locale"] rescue I18n.default_locale
    end
  end

  def page?
    @page_id.present? ? true : false
  end
  def admin?
    @admin.present? ? @admin : false
  end
  def user?
    @user_id.present? ? true : false
  end
  def page_liked?
    @liked.present? ? @liked : false
  end
  def page_registered?
    (@page_id.present? and page = Social::Page.find_by_page_id(@page_id)) ? true : false
  end

end
