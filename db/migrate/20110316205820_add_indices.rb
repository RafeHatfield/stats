class AddIndices < ActiveRecord::Migration
  def self.up
    add_index :daily_keyphrase_views, :article_id
    add_index :daily_keyphrase_views, :writer_id
    add_index :daily_domain_views, :article_id
    add_index :daily_domain_views, :writer_id
    add_index :daily_page_views, :article_id
    add_index :daily_page_views, :writer_id
    add_index :articles, :suite101_article_id
    add_index :articles, :writer_id
    add_index :raw_page_views, :suite101_article_id
    add_index :raw_page_views, :writer_id
    add_index :raw_page_views, :cookie_id
  end

  def self.down
    remove_index :daily_keyphrase_views, :article_id
    remove_index :daily_keyphrase_views, :writer_id
    remove_index :daily_domain_views, :article_id
    remove_index :daily_domain_views, :writer_id
    remove_index :daily_page_views, :article_id
    remove_index :daily_page_views, :writer_id
    remove_index :articles, :suite101_article_id
    remove_index :articles, :writer_id
    remove_index :raw_page_views, :suite101_article_id
    remove_index :raw_page_views, :writer_id
    remove_index :raw_page_views, :cookie_id
  end
end