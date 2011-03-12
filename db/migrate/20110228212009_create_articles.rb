class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.integer :suite101_article_id
      t.string :title
      t.integer :writer_id
      t.string :permalink

      t.timestamps
    end
  end

  def self.down
    drop_table :articles
  end
end
