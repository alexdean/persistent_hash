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

ActiveRecord::Schema.define(version: 20150519145619) do

  create_table "persistent_hash", force: :cascade do |t|
    t.string   "key_name",       null: false
    t.string   "readable_value", null: false
    t.text     "marshalled",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "persistent_hash", ["key_name"], name: "index_persistent_hash_on_key_name", unique: true

end
