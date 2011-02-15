class PageView < Ohm::Model
  attribute :page_id
  attribute :page_title
  attribute :page_url
  
  attribute :writer_id
  attribute :visited_at
  attribute :referer_url
  attribute :cookie_id

  index :writer_id
end