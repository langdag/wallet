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

ActiveRecord::Schema.define(version: 2021_04_24_070617) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_transactions", force: :cascade do |t|
    t.decimal "amount"
    t.integer "transaction_type"
    t.integer "origin_account_id"
    t.integer "recipient_account_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["origin_account_id"], name: "index_account_transactions_on_origin_account_id"
    t.index ["recipient_account_id"], name: "index_account_transactions_on_recipient_account_id"
  end

  create_table "accounts", force: :cascade do |t|
    t.integer "account_type"
    t.decimal "balance", precision: 15, scale: 2, default: "0.0", null: false
    t.string "account_number"
    t.integer "owner_id"
    t.string "owner_type"
    t.string "currency"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_number"], name: "index_accounts_on_account_number", unique: true
    t.index ["owner_type", "owner_id"], name: "index_accounts_on_owner_type_and_owner_id"
  end

  create_table "stocks", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.string "company"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.string "tagline"
    t.integer "team_size"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
