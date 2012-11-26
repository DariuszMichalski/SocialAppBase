class Users::OmniauthCallbacksController < ApplicationController
  include FacebookSession

  def facebook

    # logowanie przez redirect
    if request.env["omniauth.auth"]
      data = request.env["omniauth.auth"].extra.raw_info
      user_params = {
        :email        => data.email,
        :facebook_uid => request.env["omniauth.auth"].uid,
        :facebook_access_token => request.env["omniauth.auth"].credentials.token.to_s,
        :first_name   => data.first_name,
        :last_name    => data.last_name
      }
    # logowanie przez Javascript z authorize view
    elsif params[:user_data]
      user_params = params[:user_data]
    end
      

    @user = User.find_for_facebook_oauth(user_params)

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
      sign_in @user, :event => :authentication

      respond_to do |format|
        # logowanie przez redirect
        format.html {
          if !fb_session.admin? and fb_session.page_registered?
            render :text => "<html><body><script type='text/javascript'>window.top.location.href = '#{request.protocol}www.facebook.com/#{fb_session.page_id}?sk=app_#{SocialAppBase.config.app_id}';</script></body></html>"
          else
            render :text => "<html><body><script type='text/javascript'>window.top.location.href = 'https://www.facebook.com/add.php?api_key=#{SocialAppBase.config.app_id}&pages=1';</script></body></html>"
          end
        }
        # logowanie przez Javascript z authorize view
        format.json {
          if !fb_session.admin? and fb_session.page_registered?
            render :json => {success: true, register_page: false}
          else
            render :json => {success: true, register_page: true}
          end
        }
      end

    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def passthru
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end

end
