# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_23_071528) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "areas", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "course_routes", force: :cascade do |t|
    t.bigint "model_course_id", null: false
    t.integer "order"
    t.bigint "spot_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["model_course_id"], name: "index_course_routes_on_model_course_id"
    t.index ["spot_id"], name: "index_course_routes_on_spot_id"
  end

  create_table "distances", force: :cascade do |t|
    t.bigint "start_spot_id", null: false
    t.bigint "end_spot_id", null: false
    t.float "value"
    t.integer "travel_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["end_spot_id"], name: "index_distances_on_end_spot_id"
    t.index ["start_spot_id"], name: "index_distances_on_start_spot_id"
  end

  create_table "impressions", force: :cascade do |t|
    t.bigint "my_schedule_id", null: false
    t.bigint "spot_id", null: false
    t.string "text"
    t.string "image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["my_schedule_id"], name: "index_impressions_on_my_schedule_id"
    t.index ["spot_id"], name: "index_impressions_on_spot_id"
  end

  create_table "model_courses", force: :cascade do |t|
    t.bigint "area_id", null: false
    t.float "score"
    t.float "distance"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["area_id"], name: "index_model_courses_on_area_id"
  end

  create_table "my_schedules", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.date "date", null: false
    t.boolean "gone", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_my_schedules_on_user_id"
  end

  create_table "my_travel_courses", force: :cascade do |t|
    t.bigint "my_schedule_id", null: false
    t.integer "order"
    t.bigint "spot_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["my_schedule_id"], name: "index_my_travel_courses_on_my_schedule_id"
    t.index ["spot_id"], name: "index_my_travel_courses_on_spot_id"
  end

  create_table "spots", force: :cascade do |t|
    t.bigint "area_id", null: false
    t.string "name"
    t.integer "stay_time"
    t.string "image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "description"
    t.index ["area_id"], name: "index_spots_on_area_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "nickname"
    t.string "icon"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wants", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "spot_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["spot_id"], name: "index_wants_on_spot_id"
    t.index ["user_id"], name: "index_wants_on_user_id"
  end

  add_foreign_key "course_routes", "model_courses"
  add_foreign_key "course_routes", "spots"
  add_foreign_key "distances", "spots", column: "end_spot_id"
  add_foreign_key "distances", "spots", column: "start_spot_id"
  add_foreign_key "impressions", "my_schedules"
  add_foreign_key "impressions", "spots"
  add_foreign_key "model_courses", "areas"
  add_foreign_key "my_schedules", "users"
  add_foreign_key "my_travel_courses", "my_schedules"
  add_foreign_key "my_travel_courses", "spots"
  add_foreign_key "spots", "areas"
  add_foreign_key "wants", "spots"
  add_foreign_key "wants", "users"
end
