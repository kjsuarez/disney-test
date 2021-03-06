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

ActiveRecord::Schema.define(version: 2019_03_23_183548) do

  create_table "bonus_features", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "releaseDate"
    t.integer "duration"
    t.integer "feature_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["feature_id"], name: "index_bonus_features_on_feature_id"
  end

  create_table "episodes", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "releaseDate"
    t.integer "duration"
    t.integer "season_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["season_id"], name: "index_episodes_on_season_id"
  end

  create_table "features", force: :cascade do |t|
    t.datetime "theatricalReleaseDate"
    t.integer "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.string "description", null: false
  end

  create_table "seasons", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "releaseDate"
    t.integer "tv_show_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tv_show_id"], name: "index_seasons_on_tv_show_id"
  end

  create_table "tv_shows", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "releaseDate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
