class PageView < Ohm::Model
  # check out the ohm extension at http://labs.sinefunc.com/ohm-contrib/doc/ and https://github.com/sinefunc/ohm-contrib  
  attribute :page_id
  attribute :page_title
  attribute :page_url
  
  attribute :writer_id
  attribute :visited_at
  attribute :referer_url
  attribute :cookie_id

  index :writer_id  
  
  def validate
    assert_present :page_url, :writer_id
  end
end