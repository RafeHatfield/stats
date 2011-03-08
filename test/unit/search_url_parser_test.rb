require 'test_helper'

class SearchUrlParserTest < ActiveSupport::TestCase
  context "parsing a url" do
    setup do
      @search_url = {
        :google => "http://www.google.ca/search?q=awesome+sauce&ie=utf-8&oe=utf-8&aq=t&rls=org.mozilla:en-US:official&client=firefox-aSearchUrlParser",
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

    context "getting search engine" do
      should "get the correct search engine for valid search urls from supported engines" do
        @search_url.each do |engine, url|
          assert_equal engine, SearchUrlParser.get_search_engine(url)
        end
      end
      should "return nil for url that is not from a valid engine." do
        non_organic_url = "http://www.coke.com/iamhappywithstuff?q=thisisntasearch"
        assert_equal nil, SearchUrlParser.get_search_engine(non_organic_url)
      end
    end

    context "getting keywords" do
      should "get the correct keywords for valid search urls from supported engines" do
        @search_url.each do |engine, url|
          assert_equal @searched_keywords, SearchUrlParser.get_keywords(url, engine)
        end
      end
      should "get the correct keywords for a google search url with quoted search terms" do
        search_url = "http://www.google.ca/search?q=%22awesome%20sauce%22%20happy&ie=utf-8&oe=utf-8&aq=t&rls=org.mozilla:en-US:official&client=firefox-a"
        searched_keywords = "\"awesome sauce\" happy"
        assert_equal searched_keywords, SearchUrlParser.get_keywords(search_url, :google)
      end
      
      should "return nil if the keywords couldn't be parsed properly" do
        search_url = "http://www.google.com/imgres?imgurl=http://images.suite101.com/2851319_COM_jose_mourinho_real_madrid_1_.jpg&imgrefurl=http://www.suite101.com/content/mourinhos-real-madrid--fc-barcelona-copa-del-rey-final-2011-a342288&usg=__P35o0PEZ3gZEM8T4FgsGZp8cOH0=&h=300&w=300&sz=17&hl=en&start=43&zoom=1&tbnid=fRrHjtsOVq42NM:&tbnh=131&tbnw=131&ei=pending&prev=/images%3Fq%3Dreal%2Bmadrid%2B2011%26hl%3Den%26biw%3D1280%26bih%3D579%26gbv%3D2%26tbs%3Disch:10,788&itbs=1&iact=rc&dur=394&oei=qTtxTe22OJKGswaCp6GIDg&page=3&ndsp=21&ved=1t:429,r:12,s:43&tx=115&ty=14&biw=1280&bih=579"
        assert_equal nil, SearchUrlParser.get_keywords(search_url, :google)
      end
      
      should "get the right engine for google mobile searches" do
        search_url = "http://www.google.com/m?hl=en&gl=us&client=ms-android-verizon&source=android-unknown&action=devloc&q=awesome%20sauce"
        assert_equal :google, SearchUrlParser.get_search_engine(search_url)
      end
      
      should "properly parse google mobile searches" do
        search_url = "http://www.google.com/m?hl=en&gl=us&client=ms-android-verizon&source=android-unknown&action=devloc&q=awesome%20sauce"
        assert_equal "awesome sauce", SearchUrlParser.get_keywords(search_url, :google)
      end
    end
    
  end
  
end