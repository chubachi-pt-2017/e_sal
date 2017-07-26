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

ActiveRecord::Schema.define(version: 20170724154120) do

  create_table "activities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "trackable_type"
    t.integer  "trackable_id"
    t.string   "owner_type"
    t.integer  "owner_id"
    t.string   "key"
    t.text     "parameters",     limit: 65535
    t.string   "recipient_type"
    t.integer  "recipient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
    t.index ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
    t.index ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree
  end

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "body",        limit: 65535
    t.integer  "tutorial_id"
    t.integer  "user_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["tutorial_id"], name: "index_comments_on_tutorial_id", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "main_categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",       null: false
    t.string   "name_url",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_main_categories_on_name", unique: true, using: :btree
    t.index ["name_url"], name: "index_main_categories_on_name_url", unique: true, using: :btree
  end

  create_table "original_categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",             null: false
    t.string   "name_url",         null: false
    t.integer  "main_category_id", null: false
    t.integer  "user_id",          null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["main_category_id"], name: "index_original_categories_on_main_category_id", using: :btree
    t.index ["name"], name: "index_original_categories_on_name", unique: true, using: :btree
    t.index ["name_url"], name: "index_original_categories_on_name_url", unique: true, using: :btree
    t.index ["user_id"], name: "index_original_categories_on_user_id", using: :btree
  end

  create_table "photos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "image_updated_at"
    t.integer  "image_file_size"
    t.string   "image_content_type"
    t.string   "image_file_name"
    t.integer  "user_id",            null: false
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["user_id"], name: "index_photos_on_user_id", using: :btree
  end

  create_table "programming_answers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "programming_language", limit: 1,     default: 1, null: false
    t.text     "answer_code",          limit: 65535,             null: false
    t.text     "answer_result",        limit: 65535,             null: false
    t.integer  "answer_status",        limit: 1,     default: 0, null: false
    t.integer  "tab_size",             limit: 1,     default: 2, null: false
    t.integer  "programming_id",                                 null: false
    t.integer  "user_id",                                        null: false
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.index ["programming_id", "user_id"], name: "index_programming_answers_on_programming_id_and_user_id", unique: true, using: :btree
    t.index ["programming_id"], name: "index_programming_answers_on_programming_id", using: :btree
    t.index ["user_id"], name: "index_programming_answers_on_user_id", using: :btree
  end

  create_table "programmings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title",          limit: 128,   null: false
    t.text     "question_desc",  limit: 65535, null: false
    t.text     "correct_answer", limit: 65535
    t.integer  "user_id",                      null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["title"], name: "index_programmings_on_title", unique: true, using: :btree
    t.index ["user_id"], name: "index_programmings_on_user_id", using: :btree
  end

  create_table "tutorial_contents", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "body",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "tutorial_dislikes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id",     null: false
    t.integer  "tutorial_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["tutorial_id"], name: "index_tutorial_dislikes_on_tutorial_id", using: :btree
    t.index ["user_id"], name: "index_tutorial_dislikes_on_user_id", using: :btree
  end

  create_table "tutorial_likes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id",     null: false
    t.integer  "tutorial_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["tutorial_id"], name: "index_tutorial_likes_on_tutorial_id", using: :btree
    t.index ["user_id"], name: "index_tutorial_likes_on_user_id", using: :btree
  end

  create_table "tutorials", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title",                limit: 64,             null: false
    t.integer  "user_id"
    t.integer  "photo_id"
    t.integer  "original_category_id"
    t.integer  "tutorial_content_id"
    t.integer  "status",               limit: 1,  default: 0, null: false
    t.integer  "comment_enable_flg",   limit: 1,  default: 0
    t.datetime "datetime_for_display"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.index ["original_category_id"], name: "index_tutorials_on_original_category_id", using: :btree
    t.index ["photo_id"], name: "index_tutorials_on_photo_id", using: :btree
    t.index ["title"], name: "index_tutorials_on_title", unique: true, using: :btree
    t.index ["tutorial_content_id"], name: "index_tutorials_on_tutorial_content_id", using: :btree
    t.index ["user_id"], name: "index_tutorials_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
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

  add_foreign_key "comments", "tutorials"
  add_foreign_key "comments", "users"
  add_foreign_key "tutorial_dislikes", "tutorials"
  add_foreign_key "tutorial_dislikes", "users"
  add_foreign_key "tutorial_likes", "tutorials"
  add_foreign_key "tutorial_likes", "users"
end
