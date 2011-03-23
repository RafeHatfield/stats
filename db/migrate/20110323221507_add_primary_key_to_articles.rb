class AddPrimaryKeyToArticles < ActiveRecord::Migration
  def self.up
    execute "ALTER TABLE articles ADD PRIMARY KEY (id);"
  end

  def self.down
  end
end
