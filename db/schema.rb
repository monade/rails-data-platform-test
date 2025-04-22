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

ActiveRecord::Schema[8.0].define(version: 2025_04_22_134421) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "data_points", force: :cascade do |t|
    t.float "value", null: false
    t.datetime "detected_at", null: false
    t.bigint "data_source_id", null: false
    t.bigint "owner_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["data_source_id"], name: "index_data_points_on_data_source_id"
    t.index ["owner_id"], name: "index_data_points_on_owner_id"
  end

  create_table "data_source_kinds", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "data_sources", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "kind_id", null: false
    t.bigint "district_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["district_id"], name: "index_data_sources_on_district_id"
    t.index ["kind_id"], name: "index_data_sources_on_kind_id"
  end

  create_table "districts", force: :cascade do |t|
    t.string "name"
    t.bigint "region_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["region_id"], name: "index_districts_on_region_id"
  end

  create_table "owner_kinds", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "owners", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "kind_id", null: false
    t.bigint "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["kind_id"], name: "index_owners_on_kind_id"
    t.index ["parent_id"], name: "index_owners_on_parent_id"
  end

  create_table "regions", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "data_points", "data_sources"
  add_foreign_key "data_points", "owners"
  add_foreign_key "data_sources", "data_source_kinds", column: "kind_id"
  add_foreign_key "data_sources", "districts"
  add_foreign_key "districts", "regions"
  add_foreign_key "owners", "owner_kinds", column: "kind_id"
  add_foreign_key "owners", "owners", column: "parent_id"
end
