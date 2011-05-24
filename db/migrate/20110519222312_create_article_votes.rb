class CreateArticleVotes < ActiveRecord::Migration
  def self.up
    create_table :article_votes do |t|
      t.integer :article_id
      t.date :date
      t.text :note
      t.boolean :vote
      t.integer :writer_id

      t.timestamps
    end
  end

  def self.down
    drop_table :article_votes
  end
end
