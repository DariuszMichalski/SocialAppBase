class Social::Page < ActiveRecord::Base
  belongs_to :user

  has_attached_file :header_image,  :styles => { :small => "318x61#", :big => "525x100#" },
                                    :path =>  ":rails_root/public/system/pages/:attachment/:id/:style/:basename.:extension",
                                    :url  =>  "/system/pages/:attachment/:id/:style/:basename.:extension"

  delegate :full_name, :first_name, :last_name, :email, :facebook_uid, :to => :user, :prefix => true

  validates_presence_of :first_name, :last_name, :email
  validates_presence_of :terms_of_use, :message => I18n.t("errors.messages.terms_of_use")

  has_settings # rails-settings gem
  after_create :set_page_settings

  def fb_id
    self.page_id
  end

  def full_name # full name of person who registered the page
    self.first_name.to_s + ' ' + self.last_name.to_s
  end

  # ---------------------- PAGE BLOCK / UNBLOCK ---------------------- #
  def unblock!
    BlockedObject.unblock_page!(self)
  end
  def block!
    BlockedObject.block_page!(self)
  end
  def page_blocked? # only page blocked ?
    BlockedObject.page_blocked?(self)
  end
  def blocked? # page or user blocked ?
    BlockedObject.page_or_user_blocked?(self)
  end
  # ------------------------------------------------------------------ #

  # managing page settings #
  def access_time_expired?
    (!access_time_unlimited? and self.settings.end_date.to_date < Time.now.to_date) ? true : false
  end
  def access_time_unlimited?
    self.settings.time_limit.to_s == 'false' ? true : false
  end
  def access_available?
    (!access_time_expired? or access_time_unlimited?) ? true : false
  end

  private

  def set_page_settings
    # uwaga! przy dodaniu nowej opcji trzeba dodac ja rowniez w kontrolerze pages (admin) w akcji "update_settings"
    self.settings.time_limit = "false" # czy dostep do aplikacji jest ograniczony czasowo
    self.settings.end_date = (Time.now + 2.weeks).strftime("%Y-%m-%d") # data po upływie której aplikacja przestanie dzialac dla wybranej strony
  end

end
