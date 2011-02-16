class PageView < Ohm::Model
  include Ohm::Boundaries
  
  reference :page, Page
    
  attribute :visited_at
  attribute :referer_url
  attribute :cookie_id

  index :cookie_id  
  # check out the ohm extension at http://labs.sinefunc.com/ohm-contrib/doc/ and https://github.com/sinefunc/ohm-contrib  
  
end