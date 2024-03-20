# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_03_20_014957) do
  create_table "employees", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.integer "public_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "job_groups", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.string "name"
    t.integer "pay"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "timesheet_logs", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.datetime "date"
    t.integer "hours_worked"
    t.bigint "employee_id"
    t.bigint "job_group_id"
    t.bigint "timesheet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_timesheet_logs_on_employee_id"
    t.index ["job_group_id"], name: "index_timesheet_logs_on_job_group_id"
    t.index ["timesheet_id"], name: "index_timesheet_logs_on_timesheet_id"
  end

  create_table "timesheets", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.string "filename"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["filename"], name: "index_timesheets_on_filename", unique: true
  end

end
