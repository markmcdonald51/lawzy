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

ActiveRecord::Schema.define(version: 20160528134359) do

  create_table "dictionaries", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "edition"
    t.integer  "position"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "irs_codes", force: :cascade do |t|
    t.string   "trans_code"
    t.string   "dr_cr_file"
    t.string   "title"
    t.string   "valid_doc_code"
    t.text     "remarks"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "legals", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "parent_id"
    t.string   "source"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_id"], name: "index_legals_on_parent_id"
  end

  create_table "terms", force: :cascade do |t|
    t.string   "name"
    t.text     "definition"
    t.integer  "parent_id"
    t.integer  "dictionary_id"
    t.integer  "position"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "part_of_speech"
    t.index ["dictionary_id"], name: "index_terms_on_dictionary_id"
    t.index ["name"], name: "index_terms_on_name"
  end

end
