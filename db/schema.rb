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

ActiveRecord::Schema.define(version: 20140815051243) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "countries", force: true do |t|
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.integer  "user_id"
    t.date     "when"
    t.string   "where"
    t.string   "what"
    t.string   "remarks"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email"
    t.string   "password"
    t.string   "avatar"
    t.string   "street"
    t.string   "city"
    t.string   "country"
    t.string   "birthday"
    t.string   "birthcity"
    t.string   "birthcountry"
    t.integer  "videonumber"
    t.integer  "lastcomment"
    t.integer  "lastpost"
    t.text     "aboutme"
    t.string   "authorization_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "videos", force: true do |t|
    t.integer  "user_id"
    t.integer  "videonumber", default: 1
    t.string   "filename"
    t.string   "thumbnail"
    t.string   "title"
    t.string   "caption"
    t.integer  "views"
    t.string   "responseto"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
