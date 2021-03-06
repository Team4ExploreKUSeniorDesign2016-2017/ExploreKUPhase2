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

ActiveRecord::Schema.define(version: 20170417052039) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_users", force: :cascade do |t|
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
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "amenities", force: :cascade do |t|
    t.integer  "building_id"
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "amenities", ["building_id"], name: "index_amenities_on_building_id", using: :btree

  create_table "buildings", force: :cascade do |t|
    t.string   "image"
    t.text     "description"
    t.string   "address"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "bus_stops", force: :cascade do |t|
    t.integer  "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "departments", force: :cascade do |t|
    t.integer  "building_id"
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "departments", ["building_id"], name: "index_departments_on_building_id", using: :btree

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.decimal  "altitude"
    t.integer  "locatable_id"
    t.string   "locatable_type"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "locations", ["locatable_type", "locatable_id"], name: "index_locations_on_locatable_type_and_locatable_id", using: :btree

  create_table "parking_exceptions", force: :cascade do |t|
    t.string   "description"
    t.integer  "parking_lot_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "parking_exceptions", ["parking_lot_id"], name: "index_parking_exceptions_on_parking_lot_id", using: :btree

  create_table "parking_lots", force: :cascade do |t|
    t.integer  "lot"
    t.string   "restrictions"
    t.integer  "Gold"
    t.integer  "Blue"
    t.integer  "Red"
    t.integer  "Yellow"
    t.integer  "DaisyHill"
    t.integer  "GSPCorbin"
    t.integer  "OliverMcCarthyHalls"
    t.integer  "AlumniPlace"
    t.integer  "JayhawkTowers"
    t.integer  "SunflowerApartments"
    t.integer  "Handicap"
    t.integer  "Meter"
    t.integer  "PF"
    t.integer  "Load"
    t.integer  "Reserved"
    t.integer  "Service"
    t.integer  "State"
    t.integer  "Other"
    t.integer  "Total"
    t.integer  "Cycle"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "route_intervals", force: :cascade do |t|
    t.decimal  "delta_time"
    t.string   "shift"
    t.string   "schedule"
    t.integer  "route_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "route_intervals", ["route_id"], name: "index_route_intervals_on_route_id", using: :btree

  create_table "route_stops", force: :cascade do |t|
    t.decimal  "start_time"
    t.decimal  "end_time"
    t.string   "shift"
    t.string   "schedule"
    t.string   "line"
    t.integer  "route_id"
    t.integer  "bus_stop_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "route_stops", ["bus_stop_id"], name: "index_route_stops_on_bus_stop_id", using: :btree
  add_index "route_stops", ["route_id"], name: "index_route_stops_on_route_id", using: :btree

  create_table "routes", force: :cascade do |t|
    t.integer  "number"
    t.string   "name"
    t.string   "end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "amenities", "buildings"
  add_foreign_key "departments", "buildings"
  add_foreign_key "parking_exceptions", "parking_lots"
  add_foreign_key "route_intervals", "routes"
  add_foreign_key "route_stops", "bus_stops"
  add_foreign_key "route_stops", "routes"
end
