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

ActiveRecord::Schema.define(version: 20190605145533) do

  create_table "branch_combo_products", force: :cascade do |t|
    t.integer "branch_product_id"
    t.integer "combo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_product_id"], name: "index_branch_combo_products_on_branch_product_id"
    t.index ["combo_id"], name: "index_branch_combo_products_on_combo_id"
  end

  create_table "branch_products", force: :cascade do |t|
    t.float "sale_cost"
    t.integer "product_id"
    t.integer "branch_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_id"], name: "index_branch_products_on_branch_id"
    t.index ["product_id"], name: "index_branch_products_on_product_id"
  end

  create_table "branches", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "address"
    t.string "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "combos", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.float "sale_cost"
    t.integer "branch_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "picture_file_name"
    t.string "picture_content_type"
    t.integer "picture_file_size"
    t.datetime "picture_updated_at"
    t.index ["branch_id"], name: "index_combos_on_branch_id"
  end

  create_table "combos_fittings", id: false, force: :cascade do |t|
    t.integer "fitting_id", null: false
    t.integer "combo_id", null: false
  end

  create_table "discounts", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.float "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dosifications", force: :cascade do |t|
    t.string "authorization_number"
    t.string "dosification_key"
    t.date "valid_until"
    t.string "activity"
    t.integer "branch_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_id"], name: "index_dosifications_on_branch_id"
  end

  create_table "fittings", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.float "cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fittings_products", id: false, force: :cascade do |t|
    t.integer "fitting_id", null: false
    t.integer "product_id", null: false
  end

  create_table "invoices", force: :cascade do |t|
    t.integer "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "nit"
    t.integer "invoice_number"
    t.date "invoice_date"
    t.string "invoice_authorization"
    t.float "invoice_amount"
    t.string "invoice_code"
    t.index ["order_id"], name: "index_invoices_on_order_id"
  end

  create_table "order_discounts", force: :cascade do |t|
    t.integer "order_id"
    t.integer "discount_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discount_id"], name: "index_order_discounts_on_discount_id"
    t.index ["order_id"], name: "index_order_discounts_on_order_id"
  end

  create_table "order_item_fittings", force: :cascade do |t|
    t.integer "order_item_id"
    t.integer "fitting_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fitting_id"], name: "index_order_item_fittings_on_fitting_id"
    t.index ["order_item_id"], name: "index_order_item_fittings_on_order_item_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "branch_product_id"
    t.integer "combo_id"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "name"
    t.string "nit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "branch_id"
    t.boolean "status"
    t.float "amount_payed"
    t.text "details"
    t.boolean "order_state"
    t.float "total_order_amount"
    t.index ["branch_id"], name: "index_orders_on_branch_id"
  end

  create_table "payments", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "picture_file_name"
    t.string "picture_content_type"
    t.integer "picture_file_size"
    t.datetime "picture_updated_at"
    t.index ["category_id"], name: "index_products_on_category_id"
  end

  create_table "user_branches", force: :cascade do |t|
    t.integer "user_id"
    t.integer "branch_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_id"], name: "index_user_branches_on_branch_id"
    t.index ["user_id"], name: "index_user_branches_on_user_id"
  end

  create_table "user_roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "branch_id"
    t.integer "user_role_id"
    t.index ["branch_id"], name: "index_users_on_branch_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["user_role_id"], name: "index_users_on_user_role_id"
  end

end
