require 'test_helper'

class PageViewTest < ActiveSupport::TestCase
  
  context "on tracking page views" do
    setup do
      @page = create_page
      @pageview = create_page_view
    end

    should "create a page view" do
      assert_equal @pageview.referer_url, "http://google.com"
    end    
  end  
  
  context "get keywords and search engine from a natural referrer url" do
    setup do
      @search_url = {
        :google => "http://www.google.ca/search?q=awesome+sauce&ie=utf-8&oe=utf-8&aq=t&rls=org.mozilla:en-US:official&client=firefox-a",
        :yahoo => "http://ca.search.yahoo.com/search;_ylt=A0oGk24.bl1NlR0B2rfrFAx.;_ylc=X1MDMjExNDcyMTAwMwRfcgMyBGFvAzEEZnIDeWZwLXQtNzE1BGhvc3RwdmlkA2htNWRla29Ha3luelJmN0ZUUzlqb1FYRlJSLjZZazFkYmo0QUR3RDcEbl9ncHMDMARuX3ZwcwMwBG9yaWdpbgNzcnAEcXVlcnkDZGViYXRlIHRvcGljcyBzdWl0ZTEwMQRzYW8DMQR2dGVzdGlkAw--?p=awesome+sauce&fr2=sb-top&fr=yfp-t-715&rd=r1",
        :bing => "http://www.bing.com/search?q=awesome+sauce&x=0&y=0&form=MSNH14&qs=n&sk=",
        :msn => "http://www.msn.com/search?q=awesome+sauce&x=0&y=0&form=MSNH14&qs=n&sk=",
        :search => "http://www.search.com/search?q=awesome+sauce",
        :aol => "http://search.aol.ca/aol/search?invocationType=&query=awesome+sauce",
        :yandex => "http://yandex.com/yandsearch?text=awesome+sauce&lr=21353",
        :ask => "http://www.ask.com/web?q=awesome+sauce&search=&qsrc=0&o=0&l=dir"        
      }
      @searched_keywords = "awesome sauce"
    end

    context "keywords" do
      should "get the correct keywords" do
        @search_url.each do |engine, url|
          assert_equal @searched_keywords, PageView.get_keywords(url, engine)
        end
      end
      
      should "get the correct keywords if we have a search with quotes" do
        search_url = "http://www.google.ca/search?q=%22awesome%20sauce%22%20happy&ie=utf-8&oe=utf-8&aq=t&rls=org.mozilla:en-US:official&client=firefox-a"
        searched_keywords = "\"awesome sauce\" happy"
        assert_equal searched_keywords, PageView.get_keywords(search_url, :google)
      end
    end
    
    context "search engine" do
      should "get the correct search engine" do
        @search_url.each do |engine, url|
          assert_equal engine, PageView.get_search_engine(url)
        end
      end
      should "return nil for a non organic url" do
        non_organic_url = "http://www.coke.com/iamhappywithstuff?q=thisisntasearch"
        assert_equal nil, PageView.get_search_engine(non_organic_url)
      end
    end
    
  end

  
end