class MakeReferrerUrlLong < ActiveRecord::Migration
  
  def self.up
    change_column :raw_page_views, :referrer_url, :string, :limit => 1000
  end

  def self.down
    change_column :raw_page_views, :referrer_url, :string, :limit => 255
  end
end
