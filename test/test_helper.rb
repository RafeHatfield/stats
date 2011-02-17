ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  # fixtures :all

  # Add more helper methods to be used by all tests here...
  def create_page(hash={})
    page_hash ={:page_title=>"Chocolate has an Expiration Date", :page_url=>"http://www.suite101.com/content/chocolate-has-an-expiration-date-a347637", :page_id=>'12345', :writer_id=>"731923"}
    page_hash.merge!(hash)
    Page.create(page_hash)
  end
  
  def create_page_view(hash={})
    page_view_hash ={:visited_at=>Time.now, :referer_url=>'http://google.come', :cookie_id => '223445'}
    page_view_hash.merge!(hash)
    PageView.create(page_view_hash)
  end
end