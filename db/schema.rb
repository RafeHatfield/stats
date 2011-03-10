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

ActiveRecord::Schema.define(:version => 20110310013334) do

  create_table "articles", :force => true do |t|
    t.integer  "suite101_article_id"
    t.string   "title"
    t.integer  "writer_id"
    t.string   "permalink"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "daily_domain_views", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "domain"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "daily_keyphrase_views", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.string   "keyphrase"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "daily_page_views", :force => true do |t|
    t.date     "date"
    t.integer  "article_id"
    t.integer  "count"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "raw_page_views", :force => true do |t|
    t.integer  "suite101_article_id"
    t.string   "permalink"
    t.string   "title"
    t.integer  "writer_id"
    t.string   "referrer_url"
    t.string   "cookie_id"
    t.datetime "date"
  end

end
