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

ActiveRecord::Schema.define(version: 2020_02_14_072112) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "characters", force: :cascade do |t|
    t.integer "character_id"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "alliance_id"
    t.integer "ancestry_id"
    t.datetime "birthday"
    t.integer "bloodline_id"
    t.integer "corporation_id"
    t.text "description"
    t.string "gender"
    t.integer "race_id"
    t.decimal "security_status"
    t.text "title"
    t.index ["character_id", "name"], name: "index_characters_on_character_id_and_name", unique: true
  end

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

  create_table "corporations", force: :cascade do |t|
    t.integer "corporation_id"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "alliance_id"
    t.integer "ceo_id"
    t.integer "creator_id"
    t.datetime "date_founded"
    t.text "description"
    t.integer "home_station_id"
    t.integer "member_count"
    t.string "ticker"
    t.string "url"
    t.boolean "war_eligible"
    t.bigint "shares"
    t.index ["corporation_id", "name"], name: "index_corporations_on_corporation_id_and_name", unique: true
  end

  create_table "flags", force: :cascade do |t|
    t.integer "flag_id"
    t.text "flag_name"
    t.text "flag_text"
    t.integer "order_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["flag_id"], name: "index_flags_on_flag_id", unique: true
  end

  create_table "items", force: :cascade do |t|
    t.integer "item_type_id"
    t.integer "group_id"
    t.text "type_name"
    t.text "description"
    t.decimal "mass"
    t.decimal "volume"
    t.decimal "capacity"
    t.integer "portion_size"
    t.integer "race_id"
    t.decimal "base_price"
    t.integer "published"
    t.integer "market_group_id"
    t.integer "icon_id"
    t.integer "sound_id"
    t.integer "graphic_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["item_type_id"], name: "index_items_on_item_type_id", unique: true
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
    t.integer "flag_id"
    t.integer "quantity_destroyed"
    t.integer "quantity_dropped"
    t.integer "singleton"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["flag_id", "item_type_id", "killmail_id", "quantity_destroyed", "quantity_dropped"], name: "killmail_item_unique_index", unique: true
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
