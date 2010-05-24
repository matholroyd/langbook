# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 6) do

  create_table "cards", :force => true do |t|
    t.integer  "deck_id"
    t.text     "question"
    t.text     "answer"
    t.float    "easiness_factor"
    t.integer  "number_repetitions"
    t.integer  "quality_of_last_recall"
    t.integer  "repetition_interval"
    t.date     "next_repetition"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "last_studied"
    t.text     "question_formatted"
    t.text     "answer_formatted"
  end

  add_index "cards", ["deck_id", "last_studied", "next_repetition"], :name => "index_cards_on_deck_id_and_last_studied_and_next_repetition"
  add_index "cards", ["deck_id", "next_repetition"], :name => "index_cards_on_deck_id_and_next_repetition"
  add_index "cards", ["next_repetition", "deck_id"], :name => "index_cards_on_next_repetition_and_deck_id"

  create_table "decks", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "decks", ["user_id"], :name => "index_decks_on_user_id"

  create_table "translations", :force => true do |t|
    t.integer  "user_id"
    t.text     "original_text"
    t.integer  "original_language_id"
    t.text     "translated_text"
    t.integer  "translated_language_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "translations", ["user_id", "created_at"], :name => "index_translations_on_user_id_and_created_at"
  add_index "translations", ["user_id", "original_language_id", "translated_language_id"], :name => "index_translations_on_user_id_and_original_language_id_and_translated_language_id"

  create_table "users", :force => true do |t|
    t.string   "email",                              :null => false
    t.string   "crypted_password",                   :null => false
    t.string   "password_salt",                      :null => false
    t.string   "persistence_token",                  :null => false
    t.string   "single_access_token",                :null => false
    t.string   "perishable_token",                   :null => false
    t.integer  "login_count",         :default => 0, :null => false
    t.integer  "failed_login_count",  :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "daily_card_quota"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
