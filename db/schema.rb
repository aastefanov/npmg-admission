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

ActiveRecord::Schema.define(:version => 20120526164737) do

  create_table "applicants", :force => true do |t|
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.integer  "phone"
    t.string   "email"
    t.string   "encrypted_password"
    t.string   "password_salt"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.string   "egn"
    t.integer  "approved"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer  "version_n"
    t.datetime "last_viewed"
    t.integer  "student_id"
  end

  add_index "applicants", ["student_id"], :name => "index_applicants_on_student_id"

  create_table "assessments", :force => true do |t|
    t.integer "exam_id"
    t.integer "student_id"
    t.boolean "is_taking_exam"
    t.string  "fik_number"
    t.decimal "exam_mark",        :precision => 4, :scale => 3
    t.decimal "competition_mark", :precision => 4, :scale => 3
  end

  add_index "assessments", ["exam_id"], :name => "index_assessments_on_exam_id"
  add_index "assessments", ["is_taking_exam"], :name => "index_assessments_on_is_taking_exam"
  add_index "assessments", ["student_id"], :name => "index_assessments_on_student_id"

  create_table "assets", :force => true do |t|
    t.string   "description"
    t.integer  "applicant_id"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  add_index "assets", ["applicant_id"], :name => "index_assets_on_applicant_id"

  create_table "competitions", :force => true do |t|
    t.string  "name"
    t.integer "exam_id"
  end

  add_index "competitions", ["exam_id"], :name => "index_competitions_on_exam_id"

  create_table "configurables", :force => true do |t|
    t.string   "name"
    t.string   "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "configurables", ["name"], :name => "index_configurables_on_name"

  create_table "enrollment_assessments", :force => true do |t|
    t.integer "applicant_id"
    t.decimal "points",         :precision => 16, :scale => 3
    t.integer "competition_id"
    t.integer "exam_id"
    t.boolean "is_taking_exam"
  end

  add_index "enrollment_assessments", ["applicant_id"], :name => "index_enrollment_assessments_on_applicant_id"
  add_index "enrollment_assessments", ["competition_id"], :name => "index_enrollment_assessments_on_competition_id"
  add_index "enrollment_assessments", ["exam_id"], :name => "index_enrollment_assessments_on_exam_id"

  create_table "exams", :force => true do |t|
    t.string "name"
    t.date   "held_in"
  end

  create_table "exams_grades", :id => false, :force => true do |t|
    t.integer "exam_id"
    t.integer "grade_id"
  end

  add_index "exams_grades", ["exam_id"], :name => "index_exams_grades_on_exam_id"
  add_index "exams_grades", ["grade_id"], :name => "index_exams_grades_on_grade_id"

  create_table "grades", :force => true do |t|
    t.string "name"
  end

  create_table "points_to_marks", :force => true do |t|
    t.integer "competition_id"
    t.decimal "mark",           :precision => 4,  :scale => 3
    t.decimal "to_range",       :precision => 16, :scale => 3
  end

  add_index "points_to_marks", ["competition_id"], :name => "index_points_to_marks_on_competition_id"

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "reviews", :force => true do |t|
    t.text     "content"
    t.integer  "applicant_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "reviews", ["applicant_id"], :name => "index_reviews_on_applicant_id"

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
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.boolean  "is_girl",           :default => false
    t.boolean  "registered_online"
  end

  create_table "students_grades", :id => false, :force => true do |t|
    t.integer "student_id"
    t.integer "grade_id"
  end

  add_index "students_grades", ["grade_id"], :name => "index_students_grades_on_grade_id"
  add_index "students_grades", ["student_id"], :name => "index_students_grades_on_student_id"

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

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

end
