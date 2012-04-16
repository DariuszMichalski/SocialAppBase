class BlockedObject < ActiveRecord::Base

  # --------------------------------- PAGES ---------------------------------- #
  def self.page_blocked?(page)
    BlockedObject.find_page(page) ? true : false
  end
  def self.page_or_user_blocked?(page)
    if page.user
      BlockedObject.find(:first, :conditions => ["(blocked_item_type=? AND blocked_item_id=?) OR (blocked_item_type=? AND blocked_item_id=?)", 'Page', page.page_id, 'User', page.user_facebook_uid]) ? true : false
    else
      page_blocked?(page)
    end
  end
  def self.block_page!(page)
    if !BlockedObject.page_blocked?(page)
      block_page = BlockedObject.new(:blocked_item_type => "Page", :blocked_item_id => page.page_id)
      block_page.save
    end
  end
  def self.unblock_page!(page)
    blocked_page = BlockedObject.find_page(page)
    blocked_page.destroy if blocked_page
  end
  # ------------------------------------------------------------------------- #

  # --------------------------------- USERS --------------------------------- #
  def self.user_blocked?(user)
    BlockedObject.find_user(user) ? true : false
  end
  def self.block_user!(user)
    if !BlockedObject.user_blocked?(user)
      block_user = BlockedObject.new(:blocked_item_type => "User", :blocked_item_id => user.facebook_uid)
      block_user.save
    end
  end
  def self.unblock_user!(user)
    blocked_user = BlockedObject.find_user(user)
    blocked_user.destroy if blocked_user
  end
  # ------------------------------------------------------------------------- #

  private

  def self.find_page(page)
    BlockedObject.find(:first, :conditions => ["(blocked_item_type=? AND blocked_item_id=?)", 'Page', page.page_id])
  end

  def self.find_user(user)
    BlockedObject.find(:first, :conditions => ["(blocked_item_type=? AND blocked_item_id=?)", 'User', user.facebook_uid])
  end

end
