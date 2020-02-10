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

ActiveRecord::Schema.define(version: 2020_02_10_041613) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "constellations", force: :cascade do |t|
    t.text "constellation_name"
    t.integer "region_id"
    t.integer "constellation_id"
    t.decimal "x_coord"
    t.decimal "y_coord"
    t.decimal "z_coord"
    t.decimal "radius"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "killmail_attackers", force: :cascade do |t|
    t.integer "killmail_id"
    t.integer "attacker_id"
    t.integer "corporation_id"
    t.integer "alliance_id"
    t.integer "damage_done"
    t.boolean "final_blow"
    t.integer "security_status"
    t.integer "ship_type_id"
    t.integer "weapon_type_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["killmail_id", "attacker_id"], name: "index_killmail_attackers_on_killmail_id_and_attacker_id", unique: true
  end

  create_table "killmail_items", force: :cascade do |t|
    t.integer "killmail_id"
    t.string "item_type_id"
    t.integer "flag"
    t.integer "quantity_destroyed"
    t.integer "quantity_dropped"
    t.integer "singleton"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["flag", "item_type_id", "killmail_id", "quantity_destroyed", "quantity_dropped"], name: "killmail_item_unique_index", unique: true
  end

  create_table "killmails", force: :cascade do |t|
    t.integer "killmail_id"
    t.datetime "killmail_time"
    t.integer "solar_system_id"
    t.integer "victim_corporation_id"
    t.integer "victim_damage_taken"
    t.jsonb "victim_position"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "victim_id"
    t.integer "victim_ship_id"
    t.index ["killmail_id"], name: "index_killmails_on_killmail_id", unique: true
  end

  create_table "regions", force: :cascade do |t|
    t.text "region_name"
    t.integer "region_id"
    t.integer "constellation_id"
    t.decimal "x_coord"
    t.decimal "y_coord"
    t.decimal "z_coord"
    t.decimal "radius"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "solarsystems", force: :cascade do |t|
    t.integer "solar_system_id"
    t.text "system_name"
    t.integer "sun_type_id"
    t.decimal "security"
    t.text "security_class"
    t.integer "region_id"
    t.integer "constellation_id"
    t.decimal "x_coord"
    t.decimal "y_coord"
    t.decimal "z_coord"
    t.decimal "radius"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
