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

ActiveRecord::Schema.define(version: 20190211115645) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_users", force: :cascade do |t|
    t.string   "first_name",      limit: 25
    t.string   "last_name",       limit: 50
    t.string   "email",           limit: 100, default: "", null: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "username",        limit: 25
    t.string   "password_digest"
    t.index ["username"], name: "index_admin_users_on_username", using: :btree
  end

  create_table "admin_users_pages", id: false, force: :cascade do |t|
    t.integer "admin_user_id"
    t.integer "page_id"
    t.index ["admin_user_id", "page_id"], name: "index_admin_users_pages_on_admin_user_id_and_page_id", using: :btree
  end

  create_table "cohorts", force: :cascade do |t|
    t.string   "name"
    t.date     "begin_date"
    t.date     "end_date"
    t.boolean  "is_active"
    t.string   "comments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "enrollments", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "cohort_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cohort_id"], name: "index_enrollments_on_cohort_id", using: :btree
    t.index ["student_id"], name: "index_enrollments_on_student_id", using: :btree
  end

  create_table "pages", force: :cascade do |t|
    t.integer  "subject_id"
    t.string   "name"
    t.string   "permalink"
    t.integer  "position"
    t.boolean  "visible",    default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["permalink"], name: "index_pages_on_permalink", using: :btree
    t.index ["subject_id"], name: "index_pages_on_subject_id", using: :btree
  end

  create_table "section_edits", force: :cascade do |t|
    t.integer  "admin_user_id"
    t.integer  "section_id"
    t.string   "summary"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["admin_user_id", "section_id"], name: "index_section_edits_on_admin_user_id_and_section_id", using: :btree
  end

  create_table "sections", force: :cascade do |t|
    t.integer  "page_id"
    t.string   "name"
    t.integer  "position"
    t.boolean  "visible",      default: false
    t.string   "content_type"
    t.text     "content"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["page_id"], name: "index_sections_on_page_id", using: :btree
  end

  create_table "students", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "is_enrolled"
    t.string   "comments"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "subjects", force: :cascade do |t|
    t.string   "name"
    t.integer  "position"
    t.boolean  "visible",    default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_foreign_key "enrollments", "cohorts"
  add_foreign_key "enrollments", "students"
end
