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

ActiveRecord::Schema.define(version: 20240326165321) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pgcrypto"

  create_table "accidents", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.uuid "company_id"
    t.float "lat"
    t.float "long"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "status_id"
    t.string "registration_number"
    t.index ["company_id"], name: "index_accidents_on_company_id"
    t.index ["status_id"], name: "index_accidents_on_status_id"
    t.index ["user_id"], name: "index_accidents_on_user_id"
  end

  create_table "api_users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.uuid "company_id"
    t.string "access_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_api_users_on_company_id"
  end

  create_table "companies", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "subdomain"
    t.uuid "company_type_id"
    t.string "email"
    t.string "forename"
    t.string "surname"
    t.uuid "title_id"
    t.string "address_1"
    t.string "address_2"
    t.string "town"
    t.string "county"
    t.string "postcode"
    t.string "telephone_number"
    t.uuid "payment_type_id"
    t.integer "app_licenses"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "user_id"
    t.string "notification_email"
    t.bigint "free_period_id"
    t.index ["company_type_id"], name: "index_companies_on_company_type_id"
    t.index ["free_period_id"], name: "index_companies_on_free_period_id"
    t.index ["payment_type_id"], name: "index_companies_on_payment_type_id"
    t.index ["title_id"], name: "index_companies_on_title_id"
    t.index ["user_id"], name: "index_companies_on_user_id"
  end

  create_table "company_types", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "company_users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "company_id"
    t.uuid "user_id"
    t.boolean "is_company_admin", default: false
    t.boolean "is_app_user", default: false
    t.string "license_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "start_date"
    t.date "end_date"
    t.uuid "license_period_id"
    t.index ["company_id"], name: "index_company_users_on_company_id"
    t.index ["license_period_id"], name: "index_company_users_on_license_period_id"
    t.index ["user_id"], name: "index_company_users_on_user_id"
  end

  create_table "event_types", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "event_type_const"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "free_periods", force: :cascade do |t|
    t.string "name"
    t.string "amount"
    t.bigint "period_id"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["period_id"], name: "index_free_periods_on_period_id"
  end

  create_table "gforces", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "video_id"
    t.float "forward_force"
    t.float "side_force"
    t.float "vertical_force"
    t.datetime "detected_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["video_id"], name: "index_gforces_on_video_id"
  end

  create_table "images", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "alt"
    t.string "hint"
    t.string "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "license_periods", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "days"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "company_id"
    t.string "title"
    t.string "body"
    t.text "content"
    t.date "expires"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_messages_on_company_id"
  end

  create_table "payment_types", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "payment_type_const"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "periods", force: :cascade do |t|
    t.string "name"
    t.string "period_const"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "photos", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "accident_id"
    t.string "accident_image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["accident_id"], name: "index_photos_on_accident_id"
  end

  create_table "settings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "company_id"
    t.string "notification_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "disable_user_emails", default: false
    t.index ["company_id"], name: "index_settings_on_company_id"
  end

  create_table "speeds", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "video_id"
    t.string "speed"
    t.string "start_time"
    t.string "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["video_id"], name: "index_speeds_on_video_id"
  end

  create_table "statuses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "status_constant"
    t.integer "sort_order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "titles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_devices", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.string "endpoint_arn"
    t.string "token"
    t.string "app_version"
    t.string "system_name"
    t.string "system_version"
    t.string "device_model"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_devices_on_user_id"
  end

  create_table "user_events", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.uuid "user_device_id"
    t.string "event_type_const"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "event_time"
    t.uuid "event_type_id"
    t.index ["event_type_id"], name: "index_user_events_on_event_type_id"
    t.index ["user_device_id"], name: "index_user_events_on_user_device_id"
    t.index ["user_id"], name: "index_user_events_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "forename"
    t.string "surname"
    t.uuid "title_id"
    t.text "address"
    t.string "insurer"
    t.string "telephone_number"
    t.string "vehicle_registration"
    t.string "access_token"
    t.string "promo_code"
    t.boolean "is_admin", default: false
    t.uuid "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.boolean "call_on_false_alarm"
    t.boolean "terms_accepted", default: false
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["title_id"], name: "index_users_on_title_id"
  end

  create_table "vehicles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "accident_id"
    t.string "registration_number"
    t.string "driver_name"
    t.string "insurance_company"
    t.string "insurance_policy_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["accident_id"], name: "index_vehicles_on_accident_id"
  end

  create_table "videos", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.uuid "company_id"
    t.float "lat"
    t.float "long"
    t.string "incident_video"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "accident_id"
    t.uuid "status_id"
    t.datetime "crash_detected_time"
    t.float "forward_force"
    t.float "side_force"
    t.float "vertical_force"
    t.string "app_version"
    t.string "system_name"
    t.string "system_version"
    t.string "device_model"
    t.integer "video_number", default: -> { "nextval('video_number_seq'::regclass)" }
    t.datetime "recording_start_time"
    t.uuid "user_device_id"
    t.string "incident_video_tmp"
    t.boolean "incident_video_processing", default: false, null: false
    t.boolean "false_alarm"
    t.index ["accident_id"], name: "index_videos_on_accident_id"
    t.index ["company_id"], name: "index_videos_on_company_id"
    t.index ["status_id"], name: "index_videos_on_status_id"
    t.index ["user_device_id"], name: "index_videos_on_user_device_id"
    t.index ["user_id"], name: "index_videos_on_user_id"
  end

  create_table "witnesses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "accident_id"
    t.string "name"
    t.string "telephone_number"
    t.string "address"
    t.string "postcode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["accident_id"], name: "index_witnesses_on_accident_id"
  end

  add_foreign_key "accidents", "companies"
  add_foreign_key "accidents", "statuses"
  add_foreign_key "accidents", "users"
  add_foreign_key "api_users", "companies"
  add_foreign_key "companies", "company_types"
  add_foreign_key "companies", "free_periods"
  add_foreign_key "companies", "payment_types"
  add_foreign_key "companies", "titles"
  add_foreign_key "companies", "users"
  add_foreign_key "company_users", "companies"
  add_foreign_key "company_users", "license_periods"
  add_foreign_key "company_users", "users"
  add_foreign_key "free_periods", "periods"
  add_foreign_key "gforces", "videos"
  add_foreign_key "messages", "companies"
  add_foreign_key "photos", "accidents"
  add_foreign_key "settings", "companies"
  add_foreign_key "speeds", "videos"
  add_foreign_key "user_devices", "users"
  add_foreign_key "user_events", "event_types"
  add_foreign_key "user_events", "user_devices"
  add_foreign_key "user_events", "users"
  add_foreign_key "users", "companies"
  add_foreign_key "users", "titles"
  add_foreign_key "vehicles", "accidents"
  add_foreign_key "videos", "accidents"
  add_foreign_key "videos", "companies"
  add_foreign_key "videos", "statuses"
  add_foreign_key "videos", "user_devices"
  add_foreign_key "videos", "users"
  add_foreign_key "witnesses", "accidents"
end
