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

ActiveRecord::Schema[8.0].define(version: 2025_02_28_144037) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.integer "user_id"
    t.decimal "balance"
    t.string "currency"
    t.string "linked_phone_number_provider"
    t.string "linked_phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "exchange_rates", force: :cascade do |t|
    t.string "base_currency"
    t.string "target_currency"
    t.decimal "rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "kycs", force: :cascade do |t|
    t.integer "user_id"
    t.string "id_card_type"
    t.string "id_Card_photo_url"
    t.string "verification_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_kycs_on_user_id"
  end

  create_table "mobile_money_transactions", force: :cascade do |t|
    t.integer "account_id"
    t.string "phone_number"
    t.string "status"
    t.string "provider_reference_id"
    t.string "transaction_type"
    t.decimal "amount"
    t.string "currency"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_mobile_money_transactions_on_account_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "sender_id"
    t.integer "receiver_id"
    t.decimal "amount_sent"
    t.string "currency_sent"
    t.decimal "amount_received"
    t.string "received_currency"
    t.decimal "fees"
    t.string "fees_currency"
    t.string "transaction_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["receiver_id"], name: "index_transactions_on_receiver_id"
    t.index ["sender_id"], name: "index_transactions_on_sender_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "phone_number"
    t.string "first_name"
    t.string "last_name"
    t.string "middle_name"
    t.date "birthday"
    t.string "profile_url"
    t.string "nationality"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "accounts", "users"
  add_foreign_key "kycs", "users"
  add_foreign_key "mobile_money_transactions", "accounts"
  add_foreign_key "transactions", "accounts", column: "receiver_id"
  add_foreign_key "transactions", "accounts", column: "sender_id"
end
