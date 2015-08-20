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

ActiveRecord::Schema.define(version: 20150820112815) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "api_keys", force: :cascade do |t|
    t.string   "access_token"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.date     "date_of_birth"
    t.text     "home_address"
    t.string   "email"
    t.string   "mobile_number"
    t.string   "employment_basis"
    t.string   "classification"
    t.string   "gender"
    t.float    "pay_adjustment"
    t.integer  "xeroemployeeid"
    t.string   "preferred_name"
    t.boolean  "is_supervisor"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "xero_id"
  end

  create_table "prompa_organisations", force: :cascade do |t|
    t.string   "owner_id"
    t.string   "organisation_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "prompa_xero_connections", force: :cascade do |t|
    t.string   "prompa_organisation_id"
    t.string   "xero_organisation_id"
    t.string   "xero_token"
    t.boolean  "valid"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "settings", force: :cascade do |t|
    t.string   "consumer_key"
    t.string   "consumer_secret"
    t.string   "prompa_url"
    t.string   "prompa_token"
    t.string   "api_token"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "xero_organisations", force: :cascade do |t|
    t.string   "owner_id"
    t.string   "organisation_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
