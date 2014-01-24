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

ActiveRecord::Schema.define(version: 20140122213311) do

  create_table "categories", force: true do |t|
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_group_id"
    t.integer  "color_scheme_id"
  end

  create_table "category_groups", force: true do |t|
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "color_scheme_id"
  end

  create_table "color_schemes", force: true do |t|
    t.string   "foreground"
    t.string   "background"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "events", force: true do |t|
    t.string   "description"
    t.date     "starts_at"
    t.date     "ends_at"
    t.integer  "campaign_id"
    t.integer  "category_id"
    t.string   "repetition_type"
    t.integer  "repetition_frequency"
    t.boolean  "on_sunday"
    t.boolean  "on_monday"
    t.boolean  "on_tuesday"
    t.boolean  "on_wednesday"
    t.boolean  "on_thursday"
    t.boolean  "on_friday"
    t.boolean  "on_saturday"
    t.string   "repetition_options"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "interested_parties", force: true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stakeholders", force: true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.integer  "reminder_notification_days"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.integer  "user_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
  end

  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
