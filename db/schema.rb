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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120925163817) do

  create_table "people", :force => true do |t|
    t.date     "birthdate"
    t.string   "gender"
    t.string   "creator"
    t.boolean  "voided"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people_attribute_types", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "creator"
    t.boolean  "voided"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people_attributes", :force => true do |t|
    t.string   "people_id"
    t.string   "value"
    t.string   "people_attribute_type_id"
    t.string   "creator"
    t.boolean  "voided"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people_names", :force => true do |t|
    t.string   "people_id"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "creator"
    t.boolean  "voided"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_roles", :force => true do |t|
    t.string "user_id"
    t.string "role"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.text     "password_hash"
    t.string   "people_id"
    t.string   "creator"
    t.boolean  "voided"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
