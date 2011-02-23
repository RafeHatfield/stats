class CreateRawPageViews < ActiveRecord::Migration
  def self.up
    create_table :raw_page_views do |t|
      t.integer :tracked_page_id
      t.string :page_url
      t.string :page_title
      t.integer :writer_id
      t.string :referrer_url
      t.string :cookie_id
      t.datetime :visited_at
      
    end
  end

  def self.down
    drop_table :raw_page_views
  end
end