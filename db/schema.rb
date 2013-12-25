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

ActiveRecord::Schema.define(version: 20131225005528) do

  create_table "campaigns", force: true do |t|
    t.string   "description"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "company_id"
    t.string   "color"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "description"
    t.integer  "company_id"
    t.string   "color"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.string   "description"
    t.date     "start_date"
    t.date     "end_date"
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
    t.string   "password"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
