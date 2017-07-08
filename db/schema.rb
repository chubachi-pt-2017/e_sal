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

ActiveRecord::Schema.define(version: 20170707172313) do

  create_table "main_categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin" do |t|
    t.string   "name",       limit: 64, null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["name"], name: "index_main_categories_on_name", unique: true, using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin" do |t|
    t.string   "email",                  limit: 128, default: "",    null: false
    t.string   "encrypted_password",     limit: 256, default: "",    null: false
    t.string   "reset_password_token",   limit: 64
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 64
    t.string   "last_sign_in_ip",        limit: 64
    t.string   "confirmation_token",     limit: 64
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",                    default: 0,     null: false
    t.string   "unlock_token",           limit: 64
    t.datetime "locked_at"
    t.string   "student_id",             limit: 8,   default: "",    null: false
    t.string   "user_name",              limit: 64,  default: "",    null: false
    t.string   "second_email",           limit: 128, default: "",    null: false
    t.integer  "course_type",            limit: 1,   default: 0,     null: false
    t.integer  "age",                    limit: 1,   default: 2,     null: false
    t.integer  "gender",                 limit: 1,   default: 0,     null: false
    t.integer  "job",                    limit: 1,   default: 0,     null: false
    t.string   "job_desc",               limit: 64
    t.boolean  "term_flg",                           default: false, null: false
    t.boolean  "deleted_flg",                        default: false, null: false
    t.datetime "deleted_at"
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["second_email"], name: "index_users_on_second_email", unique: true, using: :btree
    t.index ["student_id"], name: "index_users_on_student_id", unique: true, using: :btree
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree
  end

end
