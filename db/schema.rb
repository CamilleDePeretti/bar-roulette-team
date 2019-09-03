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

ActiveRecord::Schema.define(version: 2019_09_03_125059) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.float "lat"
    t.float "lng"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "night_id"
    t.index ["night_id"], name: "index_addresses_on_night_id"
  end

  create_table "bars", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.float "lat"
    t.float "lng"
    t.string "postcode"
    t.string "city"
    t.string "state"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "category"
    t.bigint "night_id"
    t.string "foursquare_id"
    t.string "open"
    t.string "close"
    t.text "hours"
    t.string "photos", array: true
    t.text "internal_details"
    t.text "contact"
    t.text "details"
    t.integer "price"
    t.index ["night_id"], name: "index_bars_on_night_id"
  end

  create_table "nights", force: :cascade do |t|
    t.float "lat"
    t.float "lng"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "page", default: 1
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "addresses", "nights"
  add_foreign_key "bars", "nights"
end
