class Page < Ohm::Model
  attribute :writer_id
  attribute :page_title
  attribute :page_url
  attribute :page_id
  
  list :page_views, PageView
  counter :lifetime_view_count
  index :page_id
  
  def validate
    assert_present :page_url, :writer_id
  end
  
end