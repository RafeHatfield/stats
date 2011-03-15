class StandardizeRawPageViewColumnNames < ActiveRecord::Migration
  using(:com, :de, :fr, :net)
  
  def self.up
    rename_column(:raw_page_views, :tracked_page_id, :suite101_article_id)
    rename_column(:raw_page_views, :page_url, :permalink)
    rename_column(:raw_page_views, :page_title, :title)
    rename_column(:raw_page_views, :visited_at, :date)    
  end

  def self.down
    rename_column(:raw_page_views, :suite101_article_id, :tracked_page_id)
    rename_column(:raw_page_views, :permalink, :page_url)
    rename_column(:raw_page_views, :title, :page_title)
    rename_column(:raw_page_views, :date, :visited_at)
  end
end
