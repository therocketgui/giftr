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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171007133140) do

  create_table "comments", force: :cascade do |t|
    t.string  "asin"
    t.string  "user_id"
    t.string  "date"
    t.string  "content"
    t.integer "friend_id"
    t.integer "item_id"
  end

  add_index "comments", ["item_id"], name: "index_comments_on_item_id"

  create_table "friends", force: :cascade do |t|
    t.string  "name"
    t.string  "birthday"
    t.text    "like"
    t.integer "user_id"
    t.string  "token_view"
    t.string  "token_share"
    t.string  "icon"
  end

  add_index "friends", ["user_id"], name: "index_friends_on_user_id"

  create_table "items", force: :cascade do |t|
    t.string  "asin"
    t.string  "title"
    t.string  "author"
    t.string  "price"
    t.string  "image"
    t.string  "salesrank"
    t.integer "friend_id"
    t.string  "url"
  end

  add_index "items", ["friend_id"], name: "index_items_on_friend_id"

  create_table "likes", force: :cascade do |t|
    t.string  "title"
    t.integer "friend_id"
  end

  add_index "likes", ["friend_id"], name: "index_likes_on_friend_id"

  create_table "loves", force: :cascade do |t|
    t.string  "asin"
    t.string  "user_id"
    t.string  "date"
    t.integer "friend_id"
    t.integer "item_id"
  end

  add_index "loves", ["item_id"], name: "index_loves_on_item_id"

  create_table "share_friends", force: :cascade do |t|
    t.integer "user_sharing_id"
    t.integer "user_shared_with_id"
    t.integer "friend_id"
  end

  add_index "share_friends", ["friend_id"], name: "index_share_friends_on_friend_id"

  create_table "temp_items", force: :cascade do |t|
    t.string  "asin"
    t.string  "title"
    t.string  "author"
    t.string  "price"
    t.string  "image"
    t.string  "salesrank"
    t.string  "url"
    t.integer "like_id"
  end

  add_index "temp_items", ["like_id"], name: "index_temp_items_on_like_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
