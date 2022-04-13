ActiveRecord::Schema.define(version: 2022_04_08_022227) do

  enable_extension "plpgsql"

  create_table "blogs", force: :cascade do |t|
    t.text "content"
    t.text "image"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_blogs_on_user_id"
  end

  create_table "loves", force: :cascade do |t|
    t.integer "user_id"
    t.integer "blog_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "image"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "blogs", "users"
end
