class CreateTemplate < ActiveRecord::Migration
  def self.up
    text_limit = case ActiveRecord::Base.connection.adapter_name
      when 'PostgreSQL'
        { }
      else
        { :limit => 16777215 }
      end
    # --------------------- USERS -------------------- #
    create_table(:users) do |t|
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable

      t.encryptable
      t.confirmable
      t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      t.token_authenticatable

      t.string :facebook_uid
      t.string :first_name
      t.string :last_name
      t.string :facebook_access_token

      t.string :role 

      t.timestamps
    end

    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    add_index :users, :confirmation_token,   :unique => true
    add_index :users, :unlock_token,         :unique => true
    add_index :users, :authentication_token, :unique => true
    add_index :users, :facebook_uid
    add_index :users, :role
    
    # create admin user
    user = User.new(:email => "admin@example.com", :password => "abc123", :password_confirmation => "abc123")
    user.role = 'admin'
    user.save

    # -------------------- PAGES ------------------- #
    create_table :pages do |t|
      t.string  :page_id
      t.string  :first_name
      t.string  :last_name
      t.string  :email
      t.string  :company
      t.string  :phone_number
      t.string  :phone_number
      t.boolean :terms_of_use, :default => false
      t.integer :user_id
      t.boolean :fan_gate, :default => true
      t.string  :language, :default => ""
      t.timestamps
    end
    
    add_index :pages, :page_id

    # -------------------- SETTINGS -------------------- #
    create_table :settings, :force => true do |t|
      t.string  :var,         :null => false
      t.text    :value, text_limit
      t.integer :target_id
      t.string  :target_type, :limit => 30
      t.timestamps
    end

    add_index :settings, [ :target_type, :target_id, :var ], :unique => true

    # ----------------------- BLOCKED OBJECTS ---------------------- #
    create_table :blocked_objects do |t|
      t.string :blocked_item_id
      t.string :blocked_item_type
      t.timestamps
    end
    add_index :blocked_objects, :blocked_item_id
    add_index :blocked_objects, :blocked_item_type

    # ------------------------ SYSTEM LOGS ------------------------ #
    create_table :system_logs do |t|
      t.string :resource_type
      t.string :resource_id
      t.string :action
      t.text :exception, text_limit
      t.text :hashed_object, text_limit
      t.timestamps
    end
    add_index :system_logs, :resource_type
    add_index :system_logs, :resource_id

  end

  def self.down
    drop_table :users
    drop_table :pages
    drop_table :settings
    drop_table :blocked_objects
    drop_table :system_logs
  end
end