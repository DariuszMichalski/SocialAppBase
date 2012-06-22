class Social::Users::OmniauthCallbacksController < ApplicationController

  def facebook
    @user = Social::User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
      sign_in @user, :event => :authentication
      render :text => "<html><body><script type='text/javascript'>window.top.location.href = 'https://www.facebook.com/add.php?api_key=#{SocialAppBase.config.app_id}&pages=1';</script></body></html>"
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def passthru
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end

end
