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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110514200208) do

  create_table "assessments", :force => true do |t|
    t.integer "exam_id"
    t.integer "student_id"
    t.boolean "is_taking_exam"
    t.string  "fik_number"
    t.decimal "exam_mark",        :precision => 4, :scale => 3
    t.decimal "competition_mark", :precision => 4, :scale => 3
  end

  create_table "exams", :force => true do |t|
    t.string "name"
    t.date   "held_in"
  end

  create_table "exams_grades", :id => false, :force => true do |t|
    t.integer "exam_id"
    t.integer "grade_id"
  end

  create_table "grades", :force => true do |t|
    t.string "name"
  end

  create_table "rails_admin_histories", :force => true do |t|
    t.string   "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_histories_on_item_and_table_and_month_and_year"

  create_table "students", :force => true do |t|
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "egn"
    t.string   "ref_number"
    t.string   "phone"
    t.string   "email"
    t.string   "address"
    t.integer  "registered_by"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.boolean  "is_girl",       :default => false
  end

  create_table "students_grades", :id => false, :force => true do |t|
    t.integer "student_id"
    t.integer "grade_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",               :default => "",   :null => false
    t.string   "encrypted_password",  :default => "",   :null => false
    t.string   "password_salt"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "is_active",           :default => true
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
