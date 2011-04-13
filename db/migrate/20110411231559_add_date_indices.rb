class AddDateIndices < ActiveRecord::Migration
  using(:com, :de, :fr, :net) if SHARDING_ENABLED
  
  def self.up
    add_index :daily_page_views, [:date, :writer_id]
    add_index :daily_domain_views, [:date, :writer_id]
    add_index :daily_keyphrase_views, [:date, :writer_id]    
  end

  def self.down
    remove_index :daily_page_views, [:date, :writer_id]   
    remove_index :daily_domain_views, [:date, :writer_id]   
    remove_index :daily_keyphrase_views, [:date, :writer_id]   
  end
end
