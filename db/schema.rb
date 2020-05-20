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

ActiveRecord::Schema.define(version: 2020_05_16_073737) do

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

  create_table "app_settings", force: :cascade do |t|
    t.string "key", null: false
    t.string "value"
    t.index ["key"], name: "index_app_settings_on_key", unique: true
  end

  create_table "cities", force: :cascade do |t|
    t.string "name", null: false
    t.integer "region_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["region_id"], name: "index_cities_on_region_id"
  end

  create_table "exam_results", force: :cascade do |t|
    t.integer "exam_id", null: false
    t.integer "students_id", null: false
    t.integer "fik_num"
    t.integer "pts_grader1"
    t.integer "pts_grader2"
    t.integer "pts_arbitrage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exam_id", nil], name: "index_exam_results_on_exam_id_and_student_id", unique: true
    t.index ["exam_id"], name: "index_exam_results_on_exam_id"
    t.index ["students_id"], name: "index_exam_results_on_students_id"
  end

  create_table "exam_rooms", force: :cascade do |t|
    t.integer "exam_id", null: false
    t.integer "room_id", null: false
    t.integer "priority", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exam_id", "room_id"], name: "index_exam_rooms_on_exam_id_and_room_id", unique: true
    t.index ["exam_id"], name: "index_exam_rooms_on_exam_id"
    t.index ["room_id"], name: "index_exam_rooms_on_room_id"
  end

  create_table "exams", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "held_in", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string "name"
    t.string "content"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "regions", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles_users", id: false, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "role_id", null: false
    t.index ["user_id", "role_id"], name: "index_roles_users_on_user_id_and_role_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name", null: false
    t.integer "capacity", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schools", force: :cascade do |t|
    t.string "name", null: false
    t.integer "admin_id", null: false
    t.integer "city_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_schools_on_admin_id", unique: true
    t.index ["city_id"], name: "index_schools_on_city_id"
  end

  create_table "student_exams", force: :cascade do |t|
    t.integer "exam_id", null: false
    t.integer "student_id", null: false
    t.integer "room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exam_id", "student_id"], name: "index_student_exams_on_exam_id_and_student_id", unique: true
    t.index ["exam_id"], name: "index_student_exams_on_exam_id"
    t.index ["room_id"], name: "index_student_exams_on_room_id"
    t.index ["student_id"], name: "index_student_exams_on_student_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "middle_name"
    t.string "last_name", null: false
    t.integer "ref_num"
    t.integer "school_id", null: false
    t.integer "user_id", null: false
    t.datetime "approved_at"
    t.datetime "declined_at"
    t.boolean "personal_data", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ref_num"], name: "index_students_on_ref_num", unique: true, where: "([ref_num] IS NOT NULL)"
    t.index ["school_id"], name: "index_students_on_school_id"
    t.index ["user_id"], name: "index_students_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "phone", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, where: "([confirmation_token] IS NOT NULL)"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, where: "([reset_password_token] IS NOT NULL)"
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.integer "item_id", limit: 8, null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object", limit: 1073741823
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

end
