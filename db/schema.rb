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

ActiveRecord::Schema.define(version: 2020_02_23_162212) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.integer "available_tickets_count", default: 0
    t.integer "claimed_tickets_count", default: 0
    t.integer "sold_tickets_count", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tickets", force: :cascade do |t|
    t.string "guid", null: false
    t.bigint "event_id", null: false
    t.integer "status", default: 0
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "stripe_checkout_session_id"
    t.boolean "stripe_confirmed"
    t.datetime "stripe_confirmed_at"
    t.index ["event_id"], name: "index_tickets_on_event_id"
    t.index ["guid"], name: "index_tickets_on_guid", unique: true
    t.index ["name"], name: "index_tickets_on_name", unique: true
  end

  add_foreign_key "tickets", "events"
end
