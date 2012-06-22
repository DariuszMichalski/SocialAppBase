class Social::User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :trackable, :omniauthable , :registerable #, :validatable
         #:registerable, :recoverable, :rememberable, :confirmable, :lockable

  has_many :pages, :class_name => "Social::Page"
  has_settings # rails-settings gem

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
    :first_name, :last_name, :facebook_uid, :facebook_access_token,
    :uid, :token

  def admin?
    self.role == 'admin' ? true : false
  end

  def token
    self.facebook_access_token
  end

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    if user = Social::User.find_by_email(data.email)
      user
    else # Create a user with a stub password.
      user_params = {
        :email        => data.email,
        :facebook_uid => access_token.uid,
        :facebook_access_token => access_token.credentials.token.to_s,
        :first_name   => data.first_name,
        :last_name    => data.last_name
      }
      user = Social::User.new(user_params)
      user.encrypted_password = Devise.friendly_token[0,20]
      user.save!
      user
    end
  end

  # custom association
  def page(id)
    pages.find_by_id(id)
  end

  def full_name
    self.first_name.to_s + ' ' + self.last_name.to_s
  end

  # ---------------------- PAGE BLOCK / UNBLOCK ---------------------- #
  def unblock!
    BlockedObject.unblock_user!(self)
  end
  def block!
    BlockedObject.block_user!(self)
  end
  def blocked?
    BlockedObject.user_blocked?(self)
  end
  # ------------------------------------------------------------------ #

end
