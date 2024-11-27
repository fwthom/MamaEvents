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

ActiveRecord::Schema[7.1].define(version: 2024_11_27_163957) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "charities", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "contact_email"
    t.string "phone_number"
    t.string "logo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.date "date"
    t.string "location"
    t.bigint "charity_id", null: false
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["charity_id"], name: "index_events_on_charity_id"
  end

  create_table "names", force: :cascade do |t|
    t.string "description"
    t.decimal "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "options", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "category"
    t.decimal "unit_price"
    t.bigint "ticket_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_id"], name: "index_options_on_ticket_id"
  end

  create_table "options_tickets", id: false, force: :cascade do |t|
    t.bigint "ticket_id", null: false
    t.bigint "option_id", null: false
    t.index ["option_id", "ticket_id"], name: "index_options_tickets_on_option_id_and_ticket_id"
    t.index ["ticket_id", "option_id"], name: "index_options_tickets_on_ticket_id_and_option_id", unique: true
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "participation_id", null: false
    t.integer "quantity"
    t.bigint "options_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["options_id"], name: "index_orders_on_options_id"
    t.index ["participation_id"], name: "index_orders_on_participation_id"
  end

  create_table "participants", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.bigint "team_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_participants_on_team_id"
  end

  create_table "participations", force: :cascade do |t|
    t.bigint "participant_id", null: false
    t.bigint "ticket_id", null: false
    t.string "status"
    t.bigint "payment_id", null: false
    t.decimal "total_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["participant_id"], name: "index_participations_on_participant_id"
    t.index ["payment_id"], name: "index_participations_on_payment_id"
    t.index ["ticket_id"], name: "index_participations_on_ticket_id"
  end

  create_table "payments", force: :cascade do |t|
    t.decimal "amount"
    t.string "status"
    t.string "payment_reference"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tickets", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.decimal "unit_price"
    t.boolean "present"
    t.bigint "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_tickets_on_event_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "events", "charities"
  add_foreign_key "options", "tickets"
  add_foreign_key "orders", "options", column: "options_id"
  add_foreign_key "orders", "participations"
  add_foreign_key "participants", "teams"
  add_foreign_key "participations", "participants"
  add_foreign_key "participations", "payments"
  add_foreign_key "participations", "tickets"
  add_foreign_key "tickets", "events"
end
