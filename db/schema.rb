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

ActiveRecord::Schema[7.0].define(version: 2024_01_19_102051) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_albums_on_user_id"
  end

  create_table "channels", force: :cascade do |t|
    t.string "identifier"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "published_before"
    t.date "published_after"
    t.text "keywords"
    t.text "non_keywords"
    t.integer "maximum_duration"
    t.integer "minimum_duration"
    t.integer "no_of_videos"
    t.bigint "album_id"
    t.string "name"
    t.index ["album_id"], name: "index_channels_on_album_id"
    t.index ["identifier"], name: "index_channels_on_identifier", unique: true
    t.index ["user_id"], name: "index_channels_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", default: "", null: false
    t.string "youtube_api_key", default: "", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "videos", force: :cascade do |t|
    t.string "identifier"
    t.integer "duration"
    t.date "published_on"
    t.string "title"
    t.integer "views"
    t.integer "comments"
    t.integer "likes"
    t.integer "dislikes"
    t.float "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "channel_id"
    t.index ["channel_id"], name: "index_videos_on_channel_id"
  end

  add_foreign_key "albums", "users"
  add_foreign_key "channels", "albums"
  add_foreign_key "videos", "channels", primary_key: "identifier"
end
