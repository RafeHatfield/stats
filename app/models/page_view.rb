class PageView < Ohm::Model
  # check out the ohm extension at http://labs.sinefunc.com/ohm-contrib/doc/ and https://github.com/sinefunc/ohm-contrib  
  reference :page, Page
    
  attribute :visited_at
  attribute :referer_url
  attribute :cookie_id

  index :cookie_id  
  
end