#encoding: utf-8
class MainController < BaseController
  #before_filter :authenticate_user!
  before_filter :assign_uid_to_registered_page, :only => :index
  
  layout "info", :only => [:not_compatibile, :blank]

  def index
    if fb_session?          # If application is running on facebook
      if !fb_session.page?  # and not on fan page
        render "install", :layout => "install"    # display install page
      else                                                # If application is running on facebook fan page
        if fb_session.page_registered?                    # and is already registered
          redirect_to page_path(:id=>fb_session.page_id)  # show content for the page
        else                                              # If page is not registered
          redirect_to new_page_path                       # redirect to registration page
        end
      end
    else                    # If application if running outside facebook
      render "install", :layout => "install"      # display install page
    end
  end

  def blank
  end
  def not_compatibile
  end
  def clear_session
    clear_fb_session
  end

  private

  def assign_uid_to_registered_page
    # method checks if user accessing the fan page is an admin,
    # and if he is signed in to the app, his uid will be assigned to
    # registered page (if there is no uid signed before)
    if fb_session? and fb_session.page? and fb_session.admin? and fb_session.user?
      user = User.find_by_facebook_uid(fb_session.user_id)
      if user
        page = Page.find_by_page_id(fb_session.page_id)
        page.update_attribute(:user_id, user.id) if page and !page.user_id.present?
      end
    end
  end

end
