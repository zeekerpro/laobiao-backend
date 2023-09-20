# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2023_09_20_135953) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_keys", force: :cascade do |t|
    t.string "account"
    t.string "content"
    t.boolean "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "service_provider", default: "openai", null: false
  end

  create_table "chats", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "api_key_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "indexed_db_id"
    t.index ["api_key_id"], name: "index_chats_on_api_key_id"
    t.index ["user_id"], name: "index_chats_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "chat_id", null: false
    t.text "content"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "indexed_db_id"
    t.index ["chat_id"], name: "index_messages_on_chat_id"
  end

  create_table "referrals", force: :cascade do |t|
    t.string "code", null: false
    t.bigint "referred_id"
    t.bigint "referrer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["referred_id"], name: "index_referrals_on_referred_id"
    t.index ["referrer_id"], name: "index_referrals_on_referrer_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "phone"
    t.string "email"
    t.string "wechat_open_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["phone"], name: "index_users_on_phone"
    t.index ["username"], name: "index_users_on_username"
  end

  add_foreign_key "chats", "api_keys"
  add_foreign_key "chats", "users"
  add_foreign_key "messages", "chats"
  add_foreign_key "referrals", "users", column: "referred_id"
  add_foreign_key "referrals", "users", column: "referrer_id"
end
