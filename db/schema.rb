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

ActiveRecord::Schema.define(version: 20160205054948) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "arguments", force: :cascade do |t|
    t.string   "claim"
    t.string   "warrant"
    t.string   "impact"
    t.string   "citation"
    t.integer  "contention_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "arguments", ["contention_id"], name: "index_arguments_on_contention_id", using: :btree

  create_table "contentions", force: :cascade do |t|
    t.string   "topic"
    t.text     "summary"
    t.integer  "speech_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "assertion_id"
  end

  add_index "contentions", ["assertion_id"], name: "index_contentions_on_assertion_id", using: :btree
  add_index "contentions", ["speech_id"], name: "index_contentions_on_speech_id", using: :btree

  create_table "debates", force: :cascade do |t|
    t.string   "resolution"
    t.integer  "creator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "debates", ["creator_id"], name: "index_debates_on_creator_id", using: :btree

  create_table "positions", force: :cascade do |t|
    t.boolean  "affirmative"
    t.string   "value"
    t.string   "criterion"
    t.integer  "debate_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "positions", ["debate_id"], name: "index_positions_on_debate_id", using: :btree
  add_index "positions", ["user_id"], name: "index_positions_on_user_id", using: :btree

  create_table "speeches", force: :cascade do |t|
    t.integer  "position_id"
    t.integer  "speech_name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "speeches", ["position_id"], name: "index_speeches_on_position_id", using: :btree

  create_table "users", force: :cascade do |t|
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "arguments", "contentions"
  add_foreign_key "contentions", "speeches"
  add_foreign_key "debates", "users", column: "creator_id"
  add_foreign_key "positions", "debates"
  add_foreign_key "positions", "users"
  add_foreign_key "speeches", "positions"
end
