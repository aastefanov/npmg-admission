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

ActiveRecord::Schema.define(version: 2019_05_03_060258) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "approval_comments", force: :cascade do |t|
    t.integer "approval_request_id", null: false
    t.integer "user_id", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["approval_request_id"], name: "index_approval_comments_on_approval_request_id"
    t.index ["user_id"], name: "index_approval_comments_on_user_id"
  end

  create_table "approval_requests", force: :cascade do |t|
    t.integer "respond_user_id"
    t.datetime "approved_at"
    t.datetime "rejected_at"
    t.integer "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_approval_requests_on_student_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.integer "region_id"
    t.index ["region_id"], name: "index_cities_on_region_id"
  end

  create_table "exams", force: :cascade do |t|
    t.string "name"
    t.date "held_in"
  end

  create_table "exams_students", id: false, force: :cascade do |t|
    t.integer "student_id", null: false
    t.integer "exam_id", null: false
  end

  create_table "histories", force: :cascade do |t|
    t.string "message"
    t.string "username"
    t.integer "item"
    t.string "table"
    t.integer "month", limit: 2
    t.integer "year", limit: 5
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item", "table", "month", "year"], name: "index_histories_on_item_and_table_and_month_and_year"
  end

  create_table "quiz_attempt_answers", force: :cascade do |t|
    t.integer "quiz_attempt_id"
    t.integer "quiz_question_id"
    t.integer "points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quiz_attempt_id"], name: "index_quiz_attempt_answers_on_quiz_attempt_id"
    t.index ["quiz_question_id"], name: "index_quiz_attempt_answers_on_quiz_question_id"
  end

  create_table "quiz_attempt_questions_question_answers", id: false, force: :cascade do |t|
    t.integer "quiz_question_answer_id", null: false
    t.integer "quiz_attempt_question_id", null: false
  end

  create_table "quiz_attempts", force: :cascade do |t|
    t.integer "fik_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quiz_question_answers", force: :cascade do |t|
    t.integer "quiz_question_id"
    t.boolean "is_correct"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "num"
    t.index ["quiz_question_id"], name: "index_quiz_question_answers_on_quiz_question_id"
  end

  create_table "quiz_questions", force: :cascade do |t|
    t.integer "quiz_id"
    t.decimal "points"
    t.integer "num"
    t.boolean "auto_gradeable"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quiz_id"], name: "index_quiz_questions_on_quiz_id"
  end

  create_table "quizzes", force: :cascade do |t|
    t.integer "exam_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exam_id"], name: "index_quizzes_on_exam_id"
  end

  create_table "ref_to_fik_mappings", force: :cascade do |t|
    t.integer "ref_number"
    t.integer "fik_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "regions", force: :cascade do |t|
    t.string "name"
    t.string "short_name"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
  end

  create_table "roles_users", id: false, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "role_id", null: false
  end

  create_table "schools", force: :cascade do |t|
    t.string "name"
    t.integer "city_id"
    t.index ["city_id"], name: "index_schools_on_city_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "first_name"
    t.string "middle_name"
    t.string "last_name"
    t.string "ref_number"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "review"
    t.boolean "is_approved"
    t.integer "school_id"
    t.string "class_name"
    t.index ["school_id"], name: "index_students_on_school_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "password_salt"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.boolean "is_active", default: true
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.integer "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object", limit: 1073741823
    t.datetime "created_at"
    t.text "object_changes", limit: 1073741823
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

end
