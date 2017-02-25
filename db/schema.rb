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

ActiveRecord::Schema.define(version: 20170223090907) do

  create_table "articles", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "department_id"
    t.text     "content"
    t.string   "title"
    t.string   "kind"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "articles", ["department_id"], name: "index_articles_on_department_id"
  add_index "articles", ["title"], name: "index_articles_on_title"
  add_index "articles", ["user_id"], name: "index_articles_on_user_id"

  create_table "chats", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "chats_users", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "chat_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "chats_users", ["chat_id"], name: "index_chats_users_on_chat_id"
  add_index "chats_users", ["user_id"], name: "index_chats_users_on_user_id"

  create_table "departments", force: :cascade do |t|
    t.string   "name"
    t.string   "office_address"
    t.string   "office_number"
    t.integer  "number_of_people"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "materials", force: :cascade do |t|
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.integer  "user_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "materials", ["user_id"], name: "index_materials_on_user_id"

  create_table "meetings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "chat_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "messages", ["chat_id"], name: "index_messages_on_chat_id"
  add_index "messages", ["user_id"], name: "index_messages_on_user_id"

  create_table "performances", force: :cascade do |t|
    t.integer  "arriving_late"
    t.integer  "leaving"
    t.float    "training_score"
    t.string   "evaluation"
    t.integer  "user_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "performances", ["user_id"], name: "index_performances_on_user_id"

  create_table "salaries", force: :cascade do |t|
    t.integer  "user_id"
    t.float    "basic"
    t.float    "bonus"
    t.float    "insurence"
    t.float    "pulishment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "salaries", ["user_id"], name: "index_salaries_on_user_id"

  create_table "users", force: :cascade do |t|
    t.integer  "department_id"
    t.string   "name"
    t.string   "email"
    t.integer  "role"
    t.string   "password_digest"
    t.string   "remember_digest"
    t.string   "sex"
    t.string   "phonenumber"
    t.string   "status"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "users", ["department_id"], name: "index_users_on_department_id"
  add_index "users", ["email"], name: "index_users_on_email"
  add_index "users", ["name"], name: "index_users_on_name"

end
