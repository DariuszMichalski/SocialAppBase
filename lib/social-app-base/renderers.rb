module Renderers

  # ------------------------------------------------------- # renderers #
  def render_blank_and_return
    render "social/main/blank"
    return
  end
  def render_not_liked_and_return
    render "social/main/like"
    return
  end
  def render_blank_and_return_if_not_page
    render_blank_and_return if !fb_session or !fb_session.page?
  end

  # ------------------------------------------------------- # checking methods #
  def admin_rights
    render_blank_and_return if !fb_session.admin?
  end
  def check_if_fan_page_loaded
    render_blank_and_return if !fb_session.page?
  end
  def check_page_like
    render_not_liked_and_return if !fb_session.page_liked?
  end

end
