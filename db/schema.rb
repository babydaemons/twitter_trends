# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111118022101) do

  create_table "acquisitions", :force => true do |t|
    t.integer  "status_id",         :limit => 8, :default => 0, :null => false
    t.datetime "created_at"
    t.integer  "from_user_id",      :limit => 8, :default => 0, :null => false
    t.string   "from_user",                                     :null => false
    t.integer  "to_user_id",        :limit => 8
    t.string   "to_user"
    t.string   "iso_language_code",                             :null => false
    t.string   "profile_image_url",                             :null => false
    t.string   "source",                                        :null => false
    t.text     "text",                                          :null => false
    t.datetime "updated_at"
  end

  add_index "acquisitions", ["status_id"], :name => "IX_acquisitions_status_id", :unique => true

  create_table "hits", :force => true do |t|
    t.integer  "status_id",  :limit => 8, :default => 0, :null => false
    t.integer  "keyword_id", :limit => 8, :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hits", ["keyword_id", "created_at"], :name => "IX_hits_keyword_id_created_at"

  create_table "keywords", :force => true do |t|
    t.string   "keyword",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "tweets", :force => true do |t|
    t.integer  "status_id",         :limit => 8, :default => 0, :null => false
    t.datetime "created_at"
    t.integer  "from_user_id",      :limit => 8, :default => 0, :null => false
    t.string   "from_user",                                     :null => false
    t.integer  "to_user_id",        :limit => 8
    t.string   "to_user"
    t.string   "iso_language_code",                             :null => false
    t.string   "profile_image_url",                             :null => false
    t.string   "source",                                        :null => false
    t.text     "text",                                          :null => false
    t.datetime "updated_at"
  end

  add_index "tweets", ["created_at"], :name => "IX_tweets_created_at"
  add_index "tweets", ["status_id"], :name => "IX_tweets_status_id", :unique => true

end
