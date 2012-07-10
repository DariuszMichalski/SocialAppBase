# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 1) do

  create_table "blocked_objects", :force => true do |t|
    t.string   "blocked_item_id"
    t.string   "blocked_item_type"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "blocked_objects", ["blocked_item_id"], :name => "index_blocked_objects_on_blocked_item_id"
  add_index "blocked_objects", ["blocked_item_type"], :name => "index_blocked_objects_on_blocked_item_type"

  create_table "pages", :force => true do |t|
    t.string   "page_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "company"
    t.string   "phone_number"
    t.boolean  "terms_of_use", :default => false
    t.integer  "user_id"
    t.boolean  "fan_gate",     :default => true
    t.string   "language",     :default => ""
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "pages", ["page_id"], :name => "index_pages_on_page_id"

  create_table "settings", :force => true do |t|
    t.string   "var",                             :null => false
    t.text     "value",       :limit => 16777215
    t.integer  "target_id"
    t.string   "target_type", :limit => 30
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "settings", ["target_type", "target_id", "var"], :name => "index_settings_on_target_type_and_target_id_and_var", :unique => true

  create_table "system_logs", :force => true do |t|
    t.string   "resource_type"
    t.string   "resource_id"
    t.string   "action"
    t.text     "exception",     :limit => 16777215
    t.text     "hashed_object", :limit => 16777215
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  add_index "system_logs", ["resource_id"], :name => "index_system_logs_on_resource_id"
  add_index "system_logs", ["resource_type"], :name => "index_system_logs_on_resource_type"

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "password_salt"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "failed_attempts",                       :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.string   "facebook_uid"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "facebook_access_token"
    t.string   "role"
    t.datetime "created_at",                                            :null => false
    t.datetime "updated_at",                                            :null => false
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["facebook_uid"], :name => "index_users_on_facebook_uid"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["role"], :name => "index_users_on_role"
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

end
