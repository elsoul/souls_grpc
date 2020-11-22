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

ActiveRecord::Schema.define(version: 2020_07_29_164603) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "article_categories", force: :cascade do |t|
    t.string "name", null: false
    t.integer "total_articles", default: 0
    t.text "tag", default: [], array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "article_series", force: :cascade do |t|
    t.string "name", null: false
    t.string "category"
    t.integer "total_episodes", default: 0
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category"], name: "index_article_series_on_category"
    t.index ["name"], name: "index_article_series_on_name"
  end

  create_table "articles", force: :cascade do |t|
    t.string "user_id"
    t.string "title", null: false
    t.text "body", null: false
    t.string "thumnail_url", null: false
    t.datetime "public_date", null: false
    t.bigint "article_category_id", null: false
    t.boolean "is_public", default: false
    t.text "tag", default: [], array: true
    t.boolean "has_series", default: false
    t.integer "series_id", default: 0
    t.integer "episode_num", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["article_category_id"], name: "index_articles_on_article_category_id"
    t.index ["has_series"], name: "index_articles_on_has_series"
    t.index ["is_public"], name: "index_articles_on_is_public"
    t.index ["tag"], name: "index_articles_on_tag"
    t.index ["user_id"], name: "index_articles_on_user_id"
  end

  create_table "key_groups", force: :cascade do |t|
    t.string "name"
    t.string "key_name"
    t.integer "total_key_num", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_keys", force: :cascade do |t|
    t.string "user_id"
    t.bigint "key_group_id", null: false
    t.text "key"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["key_group_id"], name: "index_user_keys_on_key_group_id"
    t.index ["user_id"], name: "index_user_keys_on_user_id"
  end

  create_table "users", id: :string, force: :cascade do |t|
    t.string "username"
    t.string "screen_name"
    t.string "email"
    t.string "icon_url"
    t.string "birthday"
    t.string "lang"
    t.integer "roles_mask"
    t.integer "total_articles", default: 0
    t.integer "total_tweets", default: 0
    t.integer "gem"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["screen_name"], name: "index_users_on_screen_name"
    t.index ["username"], name: "index_users_on_username"
  end

  add_foreign_key "articles", "article_categories"
  add_foreign_key "user_keys", "key_groups"
end
