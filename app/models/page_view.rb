class PageView < Ohm::Model
  # check out the ohm extension at http://labs.sinefunc.com/ohm-contrib/doc/
  # include Ohm::Timestamping
  # include Ohm::ToHash
  # include Ohm::Boundaries
  # include Ohm::WebValidations
  # include Ohm::NumberValidations
  
  attribute :page_id
  attribute :page_title
  attribute :page_url
  
  attribute :writer_id
  attribute :visited_at
  attribute :referer_url
  attribute :cookie_id

  index :writer_id
  
  # def validate
  #   # # from NumberValidations
  #   # assert_decimal :amount
  #   # 
  #   # # or if you want it to be optional
  #   # assert_decimal :amount unless amount.to_s.empty?
  #   # 
  #   # # from WebValidations
  #   # assert_slug  :slug
  #   assert_url   :referer_url
  #   assert_email :poster_email
  # end
end