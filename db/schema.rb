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

ActiveRecord::Schema.define(:version => 20110209194558) do

  create_table "assessments", :force => true do |t|
    t.integer "exam_id"
    t.integer "student_id"
    t.decimal "exam_mark",        :precision => 10, :scale => 0
    t.decimal "competition_mark", :precision => 10, :scale => 0
    t.boolean "is_taking_exam"
  end

  create_table "exams", :force => true do |t|
    t.string "name"
    t.date   "held_in"
  end

  create_table "grades", :force => true do |t|
    t.string "name"
  end

  create_table "grades_students", :id => false, :force => true do |t|
    t.integer "exam_id"
    t.integer "grade_id"
  end

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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students_grades", :id => false, :force => true do |t|
    t.integer "student_id"
    t.integer "grade_id"
  end

end
