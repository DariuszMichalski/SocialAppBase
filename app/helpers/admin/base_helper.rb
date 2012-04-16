module Admin::BaseHelper
  def page_css_class(page)
    page.page_blocked? ? "page_blocked" : ""
  end
  def user_css_class(user)
    user.blocked? ? "user_blocked" : ""
  end
end
