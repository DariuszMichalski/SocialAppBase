class Social::BaseController < ApplicationController
  before_filter :set_session_for_facebook_page
  before_filter :enable_ie_iframe_sessions
  before_filter :set_locale
  # before_filter :print_requests

  include FacebookSession
  helper_method :fb_session?, :fb_session, :admin? # from FacebookSession module
  helper_method :t, :log, :backend?

  layout "social/application"

  def backend? # checks if user is in backend or not
    false
  end

  private

  include Renderers

  # def print_requests
  #   log "*********************************************"
  #   log "PARAMS"
  #   log params.inspect
  #   log "-----------------------"
  #   log "SIGNED REQUEST"
  #   log params[:signed_request] ? FacebookAuthentication::parse_signed_request(params[:signed_request], SocialAppBase.config.app_secret).inspect : "nil"
  #   log "----------------------- \n\n"
  # end

  def set_session_for_facebook_page
    set_facebook_session(params[:signed_request]) if params[:signed_request]
  rescue Exception => e
    puts "Exception: " + e.to_s
  end

  def authenticate_user! # overriden devise method, redirects to facebook login
    redirect_to user_omniauth_authorize_path(:facebook) if !user_signed_in?
  end

  def t(text)
    I18n.t(text)
  end

  def log(p)
    Rails.logger.info p
  end

  private

  def load_page # for [page, papers] controllers
    @page = Social::Page.find_by_id(params[:page_id]) rescue nil
    @page = Social::Page.find_by_page_id(params[:id]) if !@page
    if !@page
      render :text => t("page_not_found")
      return
    end
  end

  def enable_ie_iframe_sessions
    response.headers['P3P'] = 'CP="CAO PSA OUR"'
  end

  def set_locale
    if fb_session.locale.to_s.include?('pl')
      I18n.locale = :pl
    elsif fb_session.locale.to_s.include?('en')
      I18n.locale = :en
    else
      I18n.locale = I18n.default_locale
    end
  end  
end