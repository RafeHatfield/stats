FactoryGirl.define do

  factory :raw_page_view do
    tracked_page_id 123456
    writer_id 65432
    cookie_id "arandomcookie"
    page_title "Chocolate has an Expiration Date"
    page_url "http://www.suite101.com/content/chocolate-has-an-expiration-date-a347637"
    referrer_url "http://www.google.ca/search?q=awesome+sauce&ie=utf-8&oe=utf-8&aq=t&rls=org.mozilla:en-US:official&client=firefox-a"
    visited_at {Time.now}
  end
  
  factory :article do
    suite101_article_id 1
    title "MyString"
    writer_id 1
    permalink "MyString"
  end
  
  factory :daily_page_view do
    date "2011-02-28"
    article_id 1
    count 1
    writer_id 1
  end

end


# Old OHM Factories. These will be converted to factory_girl factories later.

# module Factory
#   
#   def params_for_page
#     {
#       :page_title=>"Chocolate has an Expiration Date", 
#       :page_url=>"http://www.suite101.com/content/chocolate-has-an-expiration-date-a347637", 
#       :tracked_page_id=>rand(100000).to_s, 
#       :writer_id=>rand(100000).to_s
#     }
#   end
#   
#   def create_page(hash={})
#     page_hash = params_for_page.merge!(hash)
#     page = Page.find(:tracked_page_id => page_hash[:tracked_page_id]).first
#     if page.blank?
#       page = Page.create(page_hash)
#     end
#     page
#   end
#   
#   # Note that we manually need to set page_id for a page_view
#   # since the association doesn't happen properly with OHM.
#   def params_for_page_view
#     {
#       :visited_at=>Time.now, 
#       :referer_url=>'http://google.com', 
#       :cookie_id => rand(100000)
#     }
#   end
#   
#   def create_page_view(hash={})
#     page_view_hash = params_for_page_view.merge(hash)
#     PageView.create(page_view_hash)
#   end
# end