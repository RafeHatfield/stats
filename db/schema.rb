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

ActiveRecord::Schema.define(:version => 20110519222312) do

  create_table "article_votes", :force => true do |t|
    t.integer  "article_id"
    t.date     "date"
    t.text     "note"
    t.boolean  "vote"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "articles", :id => false, :force => true do |t|
    t.integer   "id",                      :null => false
    t.string    "title"
    t.integer   "writer_id"
    t.string    "permalink"
    t.timestamp "created_at", :limit => 6
    t.timestamp "updated_at", :limit => 6
  end

  add_index "articles", ["writer_id"], :name => "index_articles_on_writer_id"

  create_table "daily_domain_views", :id => false, :force => true do |t|
    t.integer   "id",                      :null => false
    t.date      "date"
    t.integer   "article_id"
    t.string    "domain"
    t.integer   "count"
    t.integer   "writer_id"
    t.timestamp "created_at", :limit => 6
    t.timestamp "updated_at", :limit => 6
  end

  create_table "daily_domain_views_0", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "domain"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_domain_views_0", ["article_id", "date"], :name => "index_daily_domain_views_master_0_on_article_id_n_date"
  add_index "daily_domain_views_0", ["date", "domain"], :name => "index_daily_domain_views_master_0_on_date_n_domain"
  add_index "daily_domain_views_0", ["domain"], :name => "index_daily_domain_views_master_0_on_domain"
  add_index "daily_domain_views_0", ["writer_id", "date"], :name => "index_daily_domain_views_master_0_on_writer_id_n_date"

  create_table "daily_domain_views_1", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "domain"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_domain_views_1", ["article_id", "date"], :name => "index_daily_domain_views_master_1_on_article_id_n_date"
  add_index "daily_domain_views_1", ["date", "domain"], :name => "index_daily_domain_views_master_1_on_date_n_domain"
  add_index "daily_domain_views_1", ["domain"], :name => "index_daily_domain_views_master_1_on_domain"
  add_index "daily_domain_views_1", ["writer_id", "date"], :name => "index_daily_domain_views_master_1_on_writer_id_n_date"

  create_table "daily_domain_views_10", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "domain"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_domain_views_10", ["article_id", "date"], :name => "index_daily_domain_views_master_10_on_article_id_n_date"
  add_index "daily_domain_views_10", ["date", "domain"], :name => "index_daily_domain_views_master_10_on_date_n_domain"
  add_index "daily_domain_views_10", ["domain"], :name => "index_daily_domain_views_master_10_on_domain"
  add_index "daily_domain_views_10", ["writer_id", "date"], :name => "index_daily_domain_views_master_10_on_writer_id_n_date"

  create_table "daily_domain_views_11", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "domain"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_domain_views_11", ["article_id", "date"], :name => "index_daily_domain_views_master_11_on_article_id_n_date"
  add_index "daily_domain_views_11", ["date", "domain"], :name => "index_daily_domain_views_master_11_on_date_n_domain"
  add_index "daily_domain_views_11", ["domain"], :name => "index_daily_domain_views_master_11_on_domain"
  add_index "daily_domain_views_11", ["writer_id", "date"], :name => "index_daily_domain_views_master_11_on_writer_id_n_date"

  create_table "daily_domain_views_12", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "domain"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_domain_views_12", ["article_id", "date"], :name => "index_daily_domain_views_master_12_on_article_id_n_date"
  add_index "daily_domain_views_12", ["date", "domain"], :name => "index_daily_domain_views_master_12_on_date_n_domain"
  add_index "daily_domain_views_12", ["domain"], :name => "index_daily_domain_views_master_12_on_domain"
  add_index "daily_domain_views_12", ["writer_id", "date"], :name => "index_daily_domain_views_master_12_on_writer_id_n_date"

  create_table "daily_domain_views_13", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "domain"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_domain_views_13", ["article_id", "date"], :name => "index_daily_domain_views_master_13_on_article_id_n_date"
  add_index "daily_domain_views_13", ["date", "domain"], :name => "index_daily_domain_views_master_13_on_date_n_domain"
  add_index "daily_domain_views_13", ["domain"], :name => "index_daily_domain_views_master_13_on_domain"
  add_index "daily_domain_views_13", ["writer_id", "date"], :name => "index_daily_domain_views_master_13_on_writer_id_n_date"

  create_table "daily_domain_views_14", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "domain"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_domain_views_14", ["article_id", "date"], :name => "index_daily_domain_views_master_14_on_article_id_n_date"
  add_index "daily_domain_views_14", ["date", "domain"], :name => "index_daily_domain_views_master_14_on_date_n_domain"
  add_index "daily_domain_views_14", ["domain"], :name => "index_daily_domain_views_master_14_on_domain"
  add_index "daily_domain_views_14", ["writer_id", "date"], :name => "index_daily_domain_views_master_14_on_writer_id_n_date"

  create_table "daily_domain_views_15", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "domain"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_domain_views_15", ["article_id", "date"], :name => "index_daily_domain_views_master_15_on_article_id_n_date"
  add_index "daily_domain_views_15", ["date", "domain"], :name => "index_daily_domain_views_master_15_on_date_n_domain"
  add_index "daily_domain_views_15", ["domain"], :name => "index_daily_domain_views_master_15_on_domain"
  add_index "daily_domain_views_15", ["writer_id", "date"], :name => "index_daily_domain_views_master_15_on_writer_id_n_date"

  create_table "daily_domain_views_16", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "domain"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_domain_views_16", ["article_id", "date"], :name => "index_daily_domain_views_master_16_on_article_id_n_date"
  add_index "daily_domain_views_16", ["date", "domain"], :name => "index_daily_domain_views_master_16_on_date_n_domain"
  add_index "daily_domain_views_16", ["domain"], :name => "index_daily_domain_views_master_16_on_domain"
  add_index "daily_domain_views_16", ["writer_id", "date"], :name => "index_daily_domain_views_master_16_on_writer_id_n_date"

  create_table "daily_domain_views_17", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "domain"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_domain_views_17", ["article_id", "date"], :name => "index_daily_domain_views_master_17_on_article_id_n_date"
  add_index "daily_domain_views_17", ["date", "domain"], :name => "index_daily_domain_views_master_17_on_date_n_domain"
  add_index "daily_domain_views_17", ["domain"], :name => "index_daily_domain_views_master_17_on_domain"
  add_index "daily_domain_views_17", ["writer_id", "date"], :name => "index_daily_domain_views_master_17_on_writer_id_n_date"

  create_table "daily_domain_views_18", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "domain"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_domain_views_18", ["article_id", "date"], :name => "index_daily_domain_views_master_18_on_article_id_n_date"
  add_index "daily_domain_views_18", ["date", "domain"], :name => "index_daily_domain_views_master_18_on_date_n_domain"
  add_index "daily_domain_views_18", ["domain"], :name => "index_daily_domain_views_master_18_on_domain"
  add_index "daily_domain_views_18", ["writer_id", "date"], :name => "index_daily_domain_views_master_18_on_writer_id_n_date"

  create_table "daily_domain_views_19", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "domain"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_domain_views_19", ["article_id", "date"], :name => "index_daily_domain_views_master_19_on_article_id_n_date"
  add_index "daily_domain_views_19", ["date", "domain"], :name => "index_daily_domain_views_master_19_on_date_n_domain"
  add_index "daily_domain_views_19", ["domain"], :name => "index_daily_domain_views_master_19_on_domain"
  add_index "daily_domain_views_19", ["writer_id", "date"], :name => "index_daily_domain_views_master_19_on_writer_id_n_date"

  create_table "daily_domain_views_2", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "domain"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_domain_views_2", ["article_id", "date"], :name => "index_daily_domain_views_master_2_on_article_id_n_date"
  add_index "daily_domain_views_2", ["date", "domain"], :name => "index_daily_domain_views_master_2_on_date_n_domain"
  add_index "daily_domain_views_2", ["domain"], :name => "index_daily_domain_views_master_2_on_domain"
  add_index "daily_domain_views_2", ["writer_id", "date"], :name => "index_daily_domain_views_master_2_on_writer_id_n_date"

  create_table "daily_domain_views_20", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "domain"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_domain_views_20", ["article_id", "date"], :name => "index_daily_domain_views_master_20_on_article_id_n_date"
  add_index "daily_domain_views_20", ["date", "domain"], :name => "index_daily_domain_views_master_20_on_date_n_domain"
  add_index "daily_domain_views_20", ["domain"], :name => "index_daily_domain_views_master_20_on_domain"
  add_index "daily_domain_views_20", ["writer_id", "date"], :name => "index_daily_domain_views_master_20_on_writer_id_n_date"

  create_table "daily_domain_views_21", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "domain"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_domain_views_21", ["article_id", "date"], :name => "index_daily_domain_views_master_21_on_article_id_n_date"
  add_index "daily_domain_views_21", ["date", "domain"], :name => "index_daily_domain_views_master_21_on_date_n_domain"
  add_index "daily_domain_views_21", ["domain"], :name => "index_daily_domain_views_master_21_on_domain"
  add_index "daily_domain_views_21", ["writer_id", "date"], :name => "index_daily_domain_views_master_21_on_writer_id_n_date"

  create_table "daily_domain_views_22", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "domain"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_domain_views_22", ["article_id", "date"], :name => "index_daily_domain_views_master_22_on_article_id_n_date"
  add_index "daily_domain_views_22", ["date", "domain"], :name => "index_daily_domain_views_master_22_on_date_n_domain"
  add_index "daily_domain_views_22", ["domain"], :name => "index_daily_domain_views_master_22_on_domain"
  add_index "daily_domain_views_22", ["writer_id", "date"], :name => "index_daily_domain_views_master_22_on_writer_id_n_date"

  create_table "daily_domain_views_23", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "domain"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_domain_views_23", ["article_id", "date"], :name => "index_daily_domain_views_master_23_on_article_id_n_date"
  add_index "daily_domain_views_23", ["date", "domain"], :name => "index_daily_domain_views_master_23_on_date_n_domain"
  add_index "daily_domain_views_23", ["domain"], :name => "index_daily_domain_views_master_23_on_domain"
  add_index "daily_domain_views_23", ["writer_id", "date"], :name => "index_daily_domain_views_master_23_on_writer_id_n_date"

  create_table "daily_domain_views_24", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "domain"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_domain_views_24", ["article_id", "date"], :name => "index_daily_domain_views_master_24_on_article_id_n_date"
  add_index "daily_domain_views_24", ["date", "domain"], :name => "index_daily_domain_views_master_24_on_date_n_domain"
  add_index "daily_domain_views_24", ["domain"], :name => "index_daily_domain_views_master_24_on_domain"
  add_index "daily_domain_views_24", ["writer_id", "date"], :name => "index_daily_domain_views_master_24_on_writer_id_n_date"

  create_table "daily_domain_views_25", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "domain"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_domain_views_25", ["article_id", "date"], :name => "index_daily_domain_views_master_25_on_article_id_n_date"
  add_index "daily_domain_views_25", ["date", "domain"], :name => "index_daily_domain_views_master_25_on_date_n_domain"
  add_index "daily_domain_views_25", ["domain"], :name => "index_daily_domain_views_master_25_on_domain"
  add_index "daily_domain_views_25", ["writer_id", "date"], :name => "index_daily_domain_views_master_25_on_writer_id_n_date"

  create_table "daily_domain_views_26", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "domain"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_domain_views_26", ["article_id", "date"], :name => "index_daily_domain_views_master_26_on_article_id_n_date"
  add_index "daily_domain_views_26", ["date", "domain"], :name => "index_daily_domain_views_master_26_on_date_n_domain"
  add_index "daily_domain_views_26", ["domain"], :name => "index_daily_domain_views_master_26_on_domain"
  add_index "daily_domain_views_26", ["writer_id", "date"], :name => "index_daily_domain_views_master_26_on_writer_id_n_date"

  create_table "daily_domain_views_27", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "domain"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_domain_views_27", ["article_id", "date"], :name => "index_daily_domain_views_master_27_on_article_id_n_date"
  add_index "daily_domain_views_27", ["date", "domain"], :name => "index_daily_domain_views_master_27_on_date_n_domain"
  add_index "daily_domain_views_27", ["domain"], :name => "index_daily_domain_views_master_27_on_domain"
  add_index "daily_domain_views_27", ["writer_id", "date"], :name => "index_daily_domain_views_master_27_on_writer_id_n_date"

  create_table "daily_domain_views_28", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "domain"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_domain_views_28", ["article_id", "date"], :name => "index_daily_domain_views_master_28_on_article_id_n_date"
  add_index "daily_domain_views_28", ["date", "domain"], :name => "index_daily_domain_views_master_28_on_date_n_domain"
  add_index "daily_domain_views_28", ["domain"], :name => "index_daily_domain_views_master_28_on_domain"
  add_index "daily_domain_views_28", ["writer_id", "date"], :name => "index_daily_domain_views_master_28_on_writer_id_n_date"

  create_table "daily_domain_views_29", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "domain"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_domain_views_29", ["article_id", "date"], :name => "index_daily_domain_views_master_29_on_article_id_n_date"
  add_index "daily_domain_views_29", ["date", "domain"], :name => "index_daily_domain_views_master_29_on_date_n_domain"
  add_index "daily_domain_views_29", ["domain"], :name => "index_daily_domain_views_master_29_on_domain"
  add_index "daily_domain_views_29", ["writer_id", "date"], :name => "index_daily_domain_views_master_29_on_writer_id_n_date"

  create_table "daily_domain_views_3", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "domain"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_domain_views_3", ["article_id", "date"], :name => "index_daily_domain_views_master_3_on_article_id_n_date"
  add_index "daily_domain_views_3", ["date", "domain"], :name => "index_daily_domain_views_master_3_on_date_n_domain"
  add_index "daily_domain_views_3", ["domain"], :name => "index_daily_domain_views_master_3_on_domain"
  add_index "daily_domain_views_3", ["writer_id", "date"], :name => "index_daily_domain_views_master_3_on_writer_id_n_date"

  create_table "daily_domain_views_30", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "domain"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_domain_views_30", ["article_id", "date"], :name => "index_daily_domain_views_master_30_on_article_id_n_date"
  add_index "daily_domain_views_30", ["date", "domain"], :name => "index_daily_domain_views_master_30_on_date_n_domain"
  add_index "daily_domain_views_30", ["domain"], :name => "index_daily_domain_views_master_30_on_domain"
  add_index "daily_domain_views_30", ["writer_id", "date"], :name => "index_daily_domain_views_master_30_on_writer_id_n_date"

  create_table "daily_domain_views_31", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "domain"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_domain_views_31", ["article_id", "date"], :name => "index_daily_domain_views_master_31_on_article_id_n_date"
  add_index "daily_domain_views_31", ["date", "domain"], :name => "index_daily_domain_views_master_31_on_date_n_domain"
  add_index "daily_domain_views_31", ["domain"], :name => "index_daily_domain_views_master_31_on_domain"
  add_index "daily_domain_views_31", ["writer_id", "date"], :name => "index_daily_domain_views_master_31_on_writer_id_n_date"

  create_table "daily_domain_views_32", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "domain"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_domain_views_32", ["article_id", "date"], :name => "index_daily_domain_views_master_32_on_article_id_n_date"
  add_index "daily_domain_views_32", ["date", "domain"], :name => "index_daily_domain_views_master_32_on_date_n_domain"
  add_index "daily_domain_views_32", ["domain"], :name => "index_daily_domain_views_master_32_on_domain"
  add_index "daily_domain_views_32", ["writer_id", "date"], :name => "index_daily_domain_views_master_32_on_writer_id_n_date"

  create_table "daily_domain_views_33", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "domain"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_domain_views_33", ["article_id", "date"], :name => "index_daily_domain_views_master_33_on_article_id_n_date"
  add_index "daily_domain_views_33", ["date", "domain"], :name => "index_daily_domain_views_master_33_on_date_n_domain"
  add_index "daily_domain_views_33", ["domain"], :name => "index_daily_domain_views_master_33_on_domain"
  add_index "daily_domain_views_33", ["writer_id", "date"], :name => "index_daily_domain_views_master_33_on_writer_id_n_date"

  create_table "daily_domain_views_34", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "domain"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_domain_views_34", ["article_id", "date"], :name => "index_daily_domain_views_master_34_on_article_id_n_date"
  add_index "daily_domain_views_34", ["date", "domain"], :name => "index_daily_domain_views_master_34_on_date_n_domain"
  add_index "daily_domain_views_34", ["domain"], :name => "index_daily_domain_views_master_34_on_domain"
  add_index "daily_domain_views_34", ["writer_id", "date"], :name => "index_daily_domain_views_master_34_on_writer_id_n_date"

  create_table "daily_domain_views_35", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "domain"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_domain_views_35", ["article_id", "date"], :name => "index_daily_domain_views_master_35_on_article_id_n_date"
  add_index "daily_domain_views_35", ["date", "domain"], :name => "index_daily_domain_views_master_35_on_date_n_domain"
  add_index "daily_domain_views_35", ["domain"], :name => "index_daily_domain_views_master_35_on_domain"
  add_index "daily_domain_views_35", ["writer_id", "date"], :name => "index_daily_domain_views_master_35_on_writer_id_n_date"

  create_table "daily_domain_views_36", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "domain"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_domain_views_36", ["article_id", "date"], :name => "index_daily_domain_views_master_36_on_article_id_n_date"
  add_index "daily_domain_views_36", ["date", "domain"], :name => "index_daily_domain_views_master_36_on_date_n_domain"
  add_index "daily_domain_views_36", ["domain"], :name => "index_daily_domain_views_master_36_on_domain"
  add_index "daily_domain_views_36", ["writer_id", "date"], :name => "index_daily_domain_views_master_36_on_writer_id_n_date"

  create_table "daily_domain_views_37", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "domain"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_domain_views_37", ["article_id", "date"], :name => "index_daily_domain_views_master_37_on_article_id_n_date"
  add_index "daily_domain_views_37", ["date", "domain"], :name => "index_daily_domain_views_master_37_on_date_n_domain"
  add_index "daily_domain_views_37", ["domain"], :name => "index_daily_domain_views_master_37_on_domain"
  add_index "daily_domain_views_37", ["writer_id", "date"], :name => "index_daily_domain_views_master_37_on_writer_id_n_date"

  create_table "daily_domain_views_38", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "domain"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_domain_views_38", ["article_id", "date"], :name => "index_daily_domain_views_master_38_on_article_id_n_date"
  add_index "daily_domain_views_38", ["date", "domain"], :name => "index_daily_domain_views_master_38_on_date_n_domain"
  add_index "daily_domain_views_38", ["domain"], :name => "index_daily_domain_views_master_38_on_domain"
  add_index "daily_domain_views_38", ["writer_id", "date"], :name => "index_daily_domain_views_master_38_on_writer_id_n_date"

  create_table "daily_domain_views_39", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "domain"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_domain_views_39", ["article_id", "date"], :name => "index_daily_domain_views_master_39_on_article_id_n_date"
  add_index "daily_domain_views_39", ["date", "domain"], :name => "index_daily_domain_views_master_39_on_date_n_domain"
  add_index "daily_domain_views_39", ["domain"], :name => "index_daily_domain_views_master_39_on_domain"
  add_index "daily_domain_views_39", ["writer_id", "date"], :name => "index_daily_domain_views_master_39_on_writer_id_n_date"

  create_table "daily_domain_views_4", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "domain"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_domain_views_4", ["article_id", "date"], :name => "index_daily_domain_views_master_4_on_article_id_n_date"
  add_index "daily_domain_views_4", ["date", "domain"], :name => "index_daily_domain_views_master_4_on_date_n_domain"
  add_index "daily_domain_views_4", ["domain"], :name => "index_daily_domain_views_master_4_on_domain"
  add_index "daily_domain_views_4", ["writer_id", "date"], :name => "index_daily_domain_views_master_4_on_writer_id_n_date"

  create_table "daily_domain_views_40", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "domain"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_domain_views_40", ["article_id", "date"], :name => "index_daily_domain_views_master_40_on_article_id_n_date"
  add_index "daily_domain_views_40", ["date", "domain"], :name => "index_daily_domain_views_master_40_on_date_n_domain"
  add_index "daily_domain_views_40", ["domain"], :name => "index_daily_domain_views_master_40_on_domain"
  add_index "daily_domain_views_40", ["writer_id", "date"], :name => "index_daily_domain_views_master_40_on_writer_id_n_date"

  create_table "daily_domain_views_5", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "domain"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_domain_views_5", ["article_id", "date"], :name => "index_daily_domain_views_master_5_on_article_id_n_date"
  add_index "daily_domain_views_5", ["date", "domain"], :name => "index_daily_domain_views_master_5_on_date_n_domain"
  add_index "daily_domain_views_5", ["domain"], :name => "index_daily_domain_views_master_5_on_domain"
  add_index "daily_domain_views_5", ["writer_id", "date"], :name => "index_daily_domain_views_master_5_on_writer_id_n_date"

  create_table "daily_domain_views_6", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "domain"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_domain_views_6", ["article_id", "date"], :name => "index_daily_domain_views_master_6_on_article_id_n_date"
  add_index "daily_domain_views_6", ["date", "domain"], :name => "index_daily_domain_views_master_6_on_date_n_domain"
  add_index "daily_domain_views_6", ["domain"], :name => "index_daily_domain_views_master_6_on_domain"
  add_index "daily_domain_views_6", ["writer_id", "date"], :name => "index_daily_domain_views_master_6_on_writer_id_n_date"

  create_table "daily_domain_views_7", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "domain"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_domain_views_7", ["article_id", "date"], :name => "index_daily_domain_views_master_7_on_article_id_n_date"
  add_index "daily_domain_views_7", ["date", "domain"], :name => "index_daily_domain_views_master_7_on_date_n_domain"
  add_index "daily_domain_views_7", ["domain"], :name => "index_daily_domain_views_master_7_on_domain"
  add_index "daily_domain_views_7", ["writer_id", "date"], :name => "index_daily_domain_views_master_7_on_writer_id_n_date"

  create_table "daily_domain_views_8", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "domain"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_domain_views_8", ["article_id", "date"], :name => "index_daily_domain_views_master_8_on_article_id_n_date"
  add_index "daily_domain_views_8", ["date", "domain"], :name => "index_daily_domain_views_master_8_on_date_n_domain"
  add_index "daily_domain_views_8", ["domain"], :name => "index_daily_domain_views_master_8_on_domain"
  add_index "daily_domain_views_8", ["writer_id", "date"], :name => "index_daily_domain_views_master_8_on_writer_id_n_date"

  create_table "daily_domain_views_9", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "domain"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_domain_views_9", ["article_id", "date"], :name => "index_daily_domain_views_master_9_on_article_id_n_date"
  add_index "daily_domain_views_9", ["date", "domain"], :name => "index_daily_domain_views_master_9_on_date_n_domain"
  add_index "daily_domain_views_9", ["domain"], :name => "index_daily_domain_views_master_9_on_domain"
  add_index "daily_domain_views_9", ["writer_id", "date"], :name => "index_daily_domain_views_master_9_on_writer_id_n_date"

  create_table "daily_domain_views_copy", :id => false, :force => true do |t|
    t.integer   "id",                      :null => false
    t.date      "date"
    t.integer   "article_id"
    t.string    "domain"
    t.integer   "count"
    t.integer   "writer_id"
    t.timestamp "created_at", :limit => 6
    t.timestamp "updated_at", :limit => 6
  end

  create_table "daily_domain_views_master", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "domain"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  create_table "daily_keyphrase_views", :force => true do |t|
    t.date      "date"
    t.integer   "article_id"
    t.string    "keyphrase"
    t.integer   "count"
    t.integer   "writer_id"
    t.timestamp "created_at", :limit => 6
    t.timestamp "updated_at", :limit => 6
  end

  add_index "daily_keyphrase_views", ["article_id", "date"], :name => "index_daily_keyphrase_views_on_article_id_n_date"
  add_index "daily_keyphrase_views", ["keyphrase"], :name => "index_daily_keyphrase_views_on_keyphrase"

  create_table "daily_keyphrase_views_0", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "keyphrase"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_keyphrase_views_0", ["article_id", "date"], :name => "index_daily_keyphrase_views_master_0_on_article_id_n_date"
  add_index "daily_keyphrase_views_0", ["keyphrase"], :name => "index_daily_keyphrase_views_master_0_on_keyphrase"
  add_index "daily_keyphrase_views_0", ["writer_id", "date"], :name => "index_daily_keyphrase_views_master_0_on_writer_id_n_date"

  create_table "daily_keyphrase_views_1", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "keyphrase"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_keyphrase_views_1", ["article_id", "date"], :name => "index_daily_keyphrase_views_master_1_on_article_id_n_date"
  add_index "daily_keyphrase_views_1", ["keyphrase"], :name => "index_daily_keyphrase_views_master_1_on_keyphrase"
  add_index "daily_keyphrase_views_1", ["writer_id", "date"], :name => "index_daily_keyphrase_views_master_1_on_writer_id_n_date"

  create_table "daily_keyphrase_views_10", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "keyphrase"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_keyphrase_views_10", ["article_id", "date"], :name => "index_daily_keyphrase_views_master_10_on_article_id_n_date"
  add_index "daily_keyphrase_views_10", ["keyphrase"], :name => "index_daily_keyphrase_views_master_10_on_keyphrase"
  add_index "daily_keyphrase_views_10", ["writer_id", "date"], :name => "index_daily_keyphrase_views_master_10_on_writer_id_n_date"

  create_table "daily_keyphrase_views_11", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "keyphrase"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_keyphrase_views_11", ["article_id", "date"], :name => "index_daily_keyphrase_views_master_11_on_article_id_n_date"
  add_index "daily_keyphrase_views_11", ["keyphrase"], :name => "index_daily_keyphrase_views_master_11_on_keyphrase"
  add_index "daily_keyphrase_views_11", ["writer_id", "date"], :name => "index_daily_keyphrase_views_master_11_on_writer_id_n_date"

  create_table "daily_keyphrase_views_12", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "keyphrase"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_keyphrase_views_12", ["article_id", "date"], :name => "index_daily_keyphrase_views_master_12_on_article_id_n_date"
  add_index "daily_keyphrase_views_12", ["keyphrase"], :name => "index_daily_keyphrase_views_master_12_on_keyphrase"
  add_index "daily_keyphrase_views_12", ["writer_id", "date"], :name => "index_daily_keyphrase_views_master_12_on_writer_id_n_date"

  create_table "daily_keyphrase_views_13", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "keyphrase"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_keyphrase_views_13", ["article_id", "date"], :name => "index_daily_keyphrase_views_master_13_on_article_id_n_date"
  add_index "daily_keyphrase_views_13", ["keyphrase"], :name => "index_daily_keyphrase_views_master_13_on_keyphrase"
  add_index "daily_keyphrase_views_13", ["writer_id", "date"], :name => "index_daily_keyphrase_views_master_13_on_writer_id_n_date"

  create_table "daily_keyphrase_views_14", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "keyphrase"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_keyphrase_views_14", ["article_id", "date"], :name => "index_daily_keyphrase_views_master_14_on_article_id_n_date"
  add_index "daily_keyphrase_views_14", ["keyphrase"], :name => "index_daily_keyphrase_views_master_14_on_keyphrase"
  add_index "daily_keyphrase_views_14", ["writer_id", "date"], :name => "index_daily_keyphrase_views_master_14_on_writer_id_n_date"

  create_table "daily_keyphrase_views_15", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "keyphrase"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_keyphrase_views_15", ["article_id", "date"], :name => "index_daily_keyphrase_views_master_15_on_article_id_n_date"
  add_index "daily_keyphrase_views_15", ["keyphrase"], :name => "index_daily_keyphrase_views_master_15_on_keyphrase"
  add_index "daily_keyphrase_views_15", ["writer_id", "date"], :name => "index_daily_keyphrase_views_master_15_on_writer_id_n_date"

  create_table "daily_keyphrase_views_16", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "keyphrase"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_keyphrase_views_16", ["article_id", "date"], :name => "index_daily_keyphrase_views_master_16_on_article_id_n_date"
  add_index "daily_keyphrase_views_16", ["keyphrase"], :name => "index_daily_keyphrase_views_master_16_on_keyphrase"
  add_index "daily_keyphrase_views_16", ["writer_id", "date"], :name => "index_daily_keyphrase_views_master_16_on_writer_id_n_date"

  create_table "daily_keyphrase_views_17", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "keyphrase"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_keyphrase_views_17", ["article_id", "date"], :name => "index_daily_keyphrase_views_master_17_on_article_id_n_date"
  add_index "daily_keyphrase_views_17", ["keyphrase"], :name => "index_daily_keyphrase_views_master_17_on_keyphrase"
  add_index "daily_keyphrase_views_17", ["writer_id", "date"], :name => "index_daily_keyphrase_views_master_17_on_writer_id_n_date"

  create_table "daily_keyphrase_views_18", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "keyphrase"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_keyphrase_views_18", ["article_id", "date"], :name => "index_daily_keyphrase_views_master_18_on_article_id_n_date"
  add_index "daily_keyphrase_views_18", ["keyphrase"], :name => "index_daily_keyphrase_views_master_18_on_keyphrase"
  add_index "daily_keyphrase_views_18", ["writer_id", "date"], :name => "index_daily_keyphrase_views_master_18_on_writer_id_n_date"

  create_table "daily_keyphrase_views_19", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "keyphrase"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_keyphrase_views_19", ["article_id", "date"], :name => "index_daily_keyphrase_views_master_19_on_article_id_n_date"
  add_index "daily_keyphrase_views_19", ["keyphrase"], :name => "index_daily_keyphrase_views_master_19_on_keyphrase"
  add_index "daily_keyphrase_views_19", ["writer_id", "date"], :name => "index_daily_keyphrase_views_master_19_on_writer_id_n_date"

  create_table "daily_keyphrase_views_2", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "keyphrase"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_keyphrase_views_2", ["article_id", "date"], :name => "index_daily_keyphrase_views_master_2_on_article_id_n_date"
  add_index "daily_keyphrase_views_2", ["keyphrase"], :name => "index_daily_keyphrase_views_master_2_on_keyphrase"
  add_index "daily_keyphrase_views_2", ["writer_id", "date"], :name => "index_daily_keyphrase_views_master_2_on_writer_id_n_date"

  create_table "daily_keyphrase_views_20", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "keyphrase"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_keyphrase_views_20", ["article_id", "date"], :name => "index_daily_keyphrase_views_master_20_on_article_id_n_date"
  add_index "daily_keyphrase_views_20", ["keyphrase"], :name => "index_daily_keyphrase_views_master_20_on_keyphrase"
  add_index "daily_keyphrase_views_20", ["writer_id", "date"], :name => "index_daily_keyphrase_views_master_20_on_writer_id_n_date"

  create_table "daily_keyphrase_views_21", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "keyphrase"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_keyphrase_views_21", ["article_id", "date"], :name => "index_daily_keyphrase_views_master_21_on_article_id_n_date"
  add_index "daily_keyphrase_views_21", ["keyphrase"], :name => "index_daily_keyphrase_views_master_21_on_keyphrase"
  add_index "daily_keyphrase_views_21", ["writer_id", "date"], :name => "index_daily_keyphrase_views_master_21_on_writer_id_n_date"

  create_table "daily_keyphrase_views_22", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "keyphrase"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_keyphrase_views_22", ["article_id", "date"], :name => "index_daily_keyphrase_views_master_22_on_article_id_n_date"
  add_index "daily_keyphrase_views_22", ["keyphrase"], :name => "index_daily_keyphrase_views_master_22_on_keyphrase"
  add_index "daily_keyphrase_views_22", ["writer_id", "date"], :name => "index_daily_keyphrase_views_master_22_on_writer_id_n_date"

  create_table "daily_keyphrase_views_23", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "keyphrase"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_keyphrase_views_23", ["article_id", "date"], :name => "index_daily_keyphrase_views_master_23_on_article_id_n_date"
  add_index "daily_keyphrase_views_23", ["keyphrase"], :name => "index_daily_keyphrase_views_master_23_on_keyphrase"
  add_index "daily_keyphrase_views_23", ["writer_id", "date"], :name => "index_daily_keyphrase_views_master_23_on_writer_id_n_date"

  create_table "daily_keyphrase_views_24", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "keyphrase"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_keyphrase_views_24", ["article_id", "date"], :name => "index_daily_keyphrase_views_master_24_on_article_id_n_date"
  add_index "daily_keyphrase_views_24", ["keyphrase"], :name => "index_daily_keyphrase_views_master_24_on_keyphrase"
  add_index "daily_keyphrase_views_24", ["writer_id", "date"], :name => "index_daily_keyphrase_views_master_24_on_writer_id_n_date"

  create_table "daily_keyphrase_views_25", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "keyphrase"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_keyphrase_views_25", ["article_id", "date"], :name => "index_daily_keyphrase_views_master_25_on_article_id_n_date"
  add_index "daily_keyphrase_views_25", ["keyphrase"], :name => "index_daily_keyphrase_views_master_25_on_keyphrase"
  add_index "daily_keyphrase_views_25", ["writer_id", "date"], :name => "index_daily_keyphrase_views_master_25_on_writer_id_n_date"

  create_table "daily_keyphrase_views_26", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "keyphrase"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_keyphrase_views_26", ["article_id", "date"], :name => "index_daily_keyphrase_views_master_26_on_article_id_n_date"
  add_index "daily_keyphrase_views_26", ["keyphrase"], :name => "index_daily_keyphrase_views_master_26_on_keyphrase"
  add_index "daily_keyphrase_views_26", ["writer_id", "date"], :name => "index_daily_keyphrase_views_master_26_on_writer_id_n_date"

  create_table "daily_keyphrase_views_27", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "keyphrase"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_keyphrase_views_27", ["article_id", "date"], :name => "index_daily_keyphrase_views_master_27_on_article_id_n_date"
  add_index "daily_keyphrase_views_27", ["keyphrase"], :name => "index_daily_keyphrase_views_master_27_on_keyphrase"
  add_index "daily_keyphrase_views_27", ["writer_id", "date"], :name => "index_daily_keyphrase_views_master_27_on_writer_id_n_date"

  create_table "daily_keyphrase_views_28", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "keyphrase"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_keyphrase_views_28", ["article_id", "date"], :name => "index_daily_keyphrase_views_master_28_on_article_id_n_date"
  add_index "daily_keyphrase_views_28", ["keyphrase"], :name => "index_daily_keyphrase_views_master_28_on_keyphrase"
  add_index "daily_keyphrase_views_28", ["writer_id", "date"], :name => "index_daily_keyphrase_views_master_28_on_writer_id_n_date"

  create_table "daily_keyphrase_views_29", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "keyphrase"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_keyphrase_views_29", ["article_id", "date"], :name => "index_daily_keyphrase_views_master_29_on_article_id_n_date"
  add_index "daily_keyphrase_views_29", ["keyphrase"], :name => "index_daily_keyphrase_views_master_29_on_keyphrase"
  add_index "daily_keyphrase_views_29", ["writer_id", "date"], :name => "index_daily_keyphrase_views_master_29_on_writer_id_n_date"

  create_table "daily_keyphrase_views_3", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "keyphrase"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_keyphrase_views_3", ["article_id", "date"], :name => "index_daily_keyphrase_views_master_3_on_article_id_n_date"
  add_index "daily_keyphrase_views_3", ["keyphrase"], :name => "index_daily_keyphrase_views_master_3_on_keyphrase"
  add_index "daily_keyphrase_views_3", ["writer_id", "date"], :name => "index_daily_keyphrase_views_master_3_on_writer_id_n_date"

  create_table "daily_keyphrase_views_30", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "keyphrase"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_keyphrase_views_30", ["article_id", "date"], :name => "index_daily_keyphrase_views_master_30_on_article_id_n_date"
  add_index "daily_keyphrase_views_30", ["keyphrase"], :name => "index_daily_keyphrase_views_master_30_on_keyphrase"
  add_index "daily_keyphrase_views_30", ["writer_id", "date"], :name => "index_daily_keyphrase_views_master_30_on_writer_id_n_date"

  create_table "daily_keyphrase_views_31", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "keyphrase"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_keyphrase_views_31", ["article_id", "date"], :name => "index_daily_keyphrase_views_master_31_on_article_id_n_date"
  add_index "daily_keyphrase_views_31", ["keyphrase"], :name => "index_daily_keyphrase_views_master_31_on_keyphrase"
  add_index "daily_keyphrase_views_31", ["writer_id", "date"], :name => "index_daily_keyphrase_views_master_31_on_writer_id_n_date"

  create_table "daily_keyphrase_views_32", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "keyphrase"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_keyphrase_views_32", ["article_id", "date"], :name => "index_daily_keyphrase_views_master_32_on_article_id_n_date"
  add_index "daily_keyphrase_views_32", ["keyphrase"], :name => "index_daily_keyphrase_views_master_32_on_keyphrase"
  add_index "daily_keyphrase_views_32", ["writer_id", "date"], :name => "index_daily_keyphrase_views_master_32_on_writer_id_n_date"

  create_table "daily_keyphrase_views_33", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "keyphrase"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_keyphrase_views_33", ["article_id", "date"], :name => "index_daily_keyphrase_views_master_33_on_article_id_n_date"
  add_index "daily_keyphrase_views_33", ["keyphrase"], :name => "index_daily_keyphrase_views_master_33_on_keyphrase"
  add_index "daily_keyphrase_views_33", ["writer_id", "date"], :name => "index_daily_keyphrase_views_master_33_on_writer_id_n_date"

  create_table "daily_keyphrase_views_34", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "keyphrase"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_keyphrase_views_34", ["article_id", "date"], :name => "index_daily_keyphrase_views_master_34_on_article_id_n_date"
  add_index "daily_keyphrase_views_34", ["keyphrase"], :name => "index_daily_keyphrase_views_master_34_on_keyphrase"
  add_index "daily_keyphrase_views_34", ["writer_id", "date"], :name => "index_daily_keyphrase_views_master_34_on_writer_id_n_date"

  create_table "daily_keyphrase_views_35", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "keyphrase"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_keyphrase_views_35", ["article_id", "date"], :name => "index_daily_keyphrase_views_master_35_on_article_id_n_date"
  add_index "daily_keyphrase_views_35", ["keyphrase"], :name => "index_daily_keyphrase_views_master_35_on_keyphrase"
  add_index "daily_keyphrase_views_35", ["writer_id", "date"], :name => "index_daily_keyphrase_views_master_35_on_writer_id_n_date"

  create_table "daily_keyphrase_views_36", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "keyphrase"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_keyphrase_views_36", ["article_id", "date"], :name => "index_daily_keyphrase_views_master_36_on_article_id_n_date"
  add_index "daily_keyphrase_views_36", ["keyphrase"], :name => "index_daily_keyphrase_views_master_36_on_keyphrase"
  add_index "daily_keyphrase_views_36", ["writer_id", "date"], :name => "index_daily_keyphrase_views_master_36_on_writer_id_n_date"

  create_table "daily_keyphrase_views_37", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "keyphrase"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_keyphrase_views_37", ["article_id", "date"], :name => "index_daily_keyphrase_views_master_37_on_article_id_n_date"
  add_index "daily_keyphrase_views_37", ["keyphrase"], :name => "index_daily_keyphrase_views_master_37_on_keyphrase"
  add_index "daily_keyphrase_views_37", ["writer_id", "date"], :name => "index_daily_keyphrase_views_master_37_on_writer_id_n_date"

  create_table "daily_keyphrase_views_38", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "keyphrase"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_keyphrase_views_38", ["article_id", "date"], :name => "index_daily_keyphrase_views_master_38_on_article_id_n_date"
  add_index "daily_keyphrase_views_38", ["keyphrase"], :name => "index_daily_keyphrase_views_master_38_on_keyphrase"
  add_index "daily_keyphrase_views_38", ["writer_id", "date"], :name => "index_daily_keyphrase_views_master_38_on_writer_id_n_date"

  create_table "daily_keyphrase_views_39", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "keyphrase"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_keyphrase_views_39", ["article_id", "date"], :name => "index_daily_keyphrase_views_master_39_on_article_id_n_date"
  add_index "daily_keyphrase_views_39", ["keyphrase"], :name => "index_daily_keyphrase_views_master_39_on_keyphrase"
  add_index "daily_keyphrase_views_39", ["writer_id", "date"], :name => "index_daily_keyphrase_views_master_39_on_writer_id_n_date"

  create_table "daily_keyphrase_views_4", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "keyphrase"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_keyphrase_views_4", ["article_id", "date"], :name => "index_daily_keyphrase_views_master_4_on_article_id_n_date"
  add_index "daily_keyphrase_views_4", ["keyphrase"], :name => "index_daily_keyphrase_views_master_4_on_keyphrase"
  add_index "daily_keyphrase_views_4", ["writer_id", "date"], :name => "index_daily_keyphrase_views_master_4_on_writer_id_n_date"

  create_table "daily_keyphrase_views_40", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "keyphrase"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_keyphrase_views_40", ["article_id", "date"], :name => "index_daily_keyphrase_views_master_40_on_article_id_n_date"
  add_index "daily_keyphrase_views_40", ["keyphrase"], :name => "index_daily_keyphrase_views_master_40_on_keyphrase"
  add_index "daily_keyphrase_views_40", ["writer_id", "date"], :name => "index_daily_keyphrase_views_master_40_on_writer_id_n_date"

  create_table "daily_keyphrase_views_5", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "keyphrase"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_keyphrase_views_5", ["article_id", "date"], :name => "index_daily_keyphrase_views_master_5_on_article_id_n_date"
  add_index "daily_keyphrase_views_5", ["keyphrase"], :name => "index_daily_keyphrase_views_master_5_on_keyphrase"
  add_index "daily_keyphrase_views_5", ["writer_id", "date"], :name => "index_daily_keyphrase_views_master_5_on_writer_id_n_date"

  create_table "daily_keyphrase_views_6", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "keyphrase"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_keyphrase_views_6", ["article_id", "date"], :name => "index_daily_keyphrase_views_master_6_on_article_id_n_date"
  add_index "daily_keyphrase_views_6", ["keyphrase"], :name => "index_daily_keyphrase_views_master_6_on_keyphrase"
  add_index "daily_keyphrase_views_6", ["writer_id", "date"], :name => "index_daily_keyphrase_views_master_6_on_writer_id_n_date"

  create_table "daily_keyphrase_views_7", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "keyphrase"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_keyphrase_views_7", ["article_id", "date"], :name => "index_daily_keyphrase_views_master_7_on_article_id_n_date"
  add_index "daily_keyphrase_views_7", ["keyphrase"], :name => "index_daily_keyphrase_views_master_7_on_keyphrase"
  add_index "daily_keyphrase_views_7", ["writer_id", "date"], :name => "index_daily_keyphrase_views_master_7_on_writer_id_n_date"

  create_table "daily_keyphrase_views_8", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "keyphrase"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_keyphrase_views_8", ["article_id", "date"], :name => "index_daily_keyphrase_views_master_8_on_article_id_n_date"
  add_index "daily_keyphrase_views_8", ["keyphrase"], :name => "index_daily_keyphrase_views_master_8_on_keyphrase"
  add_index "daily_keyphrase_views_8", ["writer_id", "date"], :name => "index_daily_keyphrase_views_master_8_on_writer_id_n_date"

  create_table "daily_keyphrase_views_9", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "keyphrase"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  add_index "daily_keyphrase_views_9", ["article_id", "date"], :name => "index_daily_keyphrase_views_master_9_on_article_id_n_date"
  add_index "daily_keyphrase_views_9", ["keyphrase"], :name => "index_daily_keyphrase_views_master_9_on_keyphrase"
  add_index "daily_keyphrase_views_9", ["writer_id", "date"], :name => "index_daily_keyphrase_views_master_9_on_writer_id_n_date"

  create_table "daily_keyphrase_views_copy", :id => false, :force => true do |t|
    t.integer   "id",                      :null => false
    t.date      "date"
    t.integer   "article_id"
    t.string    "keyphrase"
    t.integer   "count"
    t.integer   "writer_id"
    t.timestamp "created_at", :limit => 6
    t.timestamp "updated_at", :limit => 6
  end

  create_table "daily_keyphrase_views_master", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "keyphrase"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  create_table "daily_page_views", :force => true do |t|
    t.date      "date"
    t.integer   "article_id"
    t.integer   "count"
    t.integer   "writer_id"
    t.timestamp "created_at", :limit => 6
    t.timestamp "updated_at", :limit => 6
  end

  add_index "daily_page_views", ["article_id", "date"], :name => "index_daily_page_views_on_article_id_n_date"
  add_index "daily_page_views", ["writer_id", "date"], :name => "index_daily_page_views_on_date_and_writer_id"

  create_table "daily_page_views_0", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  create_table "daily_page_views_1", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  create_table "daily_page_views_10", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  create_table "daily_page_views_11", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  create_table "daily_page_views_12", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  create_table "daily_page_views_13", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  create_table "daily_page_views_14", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  create_table "daily_page_views_15", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  create_table "daily_page_views_16", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  create_table "daily_page_views_17", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  create_table "daily_page_views_18", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  create_table "daily_page_views_19", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  create_table "daily_page_views_2", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  create_table "daily_page_views_20", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  create_table "daily_page_views_21", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  create_table "daily_page_views_22", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  create_table "daily_page_views_23", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  create_table "daily_page_views_24", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  create_table "daily_page_views_25", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  create_table "daily_page_views_26", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  create_table "daily_page_views_27", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  create_table "daily_page_views_28", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  create_table "daily_page_views_29", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  create_table "daily_page_views_3", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  create_table "daily_page_views_30", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  create_table "daily_page_views_31", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  create_table "daily_page_views_32", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  create_table "daily_page_views_33", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  create_table "daily_page_views_34", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  create_table "daily_page_views_35", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  create_table "daily_page_views_36", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  create_table "daily_page_views_37", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  create_table "daily_page_views_38", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  create_table "daily_page_views_39", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  create_table "daily_page_views_4", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  create_table "daily_page_views_40", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  create_table "daily_page_views_5", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  create_table "daily_page_views_6", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  create_table "daily_page_views_7", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  create_table "daily_page_views_8", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  create_table "daily_page_views_9", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  create_table "daily_page_views_master", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partition_id"
  end

  create_table "raw_page_views", :force => true do |t|
    t.integer   "article_id"
    t.string    "permalink"
    t.string    "title"
    t.integer   "writer_id"
    t.string    "referrer_url", :limit => 1000
    t.string    "cookie_id"
    t.timestamp "date",         :limit => 6
  end

  add_index "raw_page_views", ["article_id"], :name => "index_raw_page_views_on_article_id"
  add_index "raw_page_views", ["cookie_id"], :name => "index_raw_page_views_on_cookie_id"
  add_index "raw_page_views", ["writer_id"], :name => "index_raw_page_views_on_writer_id"

end
