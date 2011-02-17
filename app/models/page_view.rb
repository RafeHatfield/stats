class PageView < Ohm::Model
  include Ohm::Boundaries
  
  reference :page, Page
    
  attribute :visited_at
  attribute :referer_url
  attribute :cookie_id
  attribute :keyword_page

  index :cookie_id  
  # check out the ohm extension at http://labs.sinefunc.com/ohm-contrib/doc/ and https://github.com/sinefunc/ohm-contrib  


  # Given a natural search engine search url return the search engine.
  # If we don't match any search engine, return nil.
  def self.get_search_engine(url)
    
    # Match "engine_name" followed by a "." with a "?" after it.
    # NOTE: Search.com matching must be last because other engines
    #       use "search." in their domain and we want to catch them first.
    
    @engine_regex = {
      :google => /google\..*\?/,
      :yahoo => /yahoo\..*\?/,
      :bing => /bing\..*\?/,
      :msn => /msn\..*\?/,
      :aol => /aol\..*\?/,
      :ask => /ask\..*\?/,
      :yandex => /yandex\..*\?/,
      :search => /www\.search\.com.*\?/
    }
                 
    @engine_regex.each do |engine, regex|
      return engine if regex.match(url)
    end

    return nil
        
  end

  # Given a search url and a valid engine symbol return a keyword string.
  # If the engine symbol is not valid then return nil.
  def self.get_keywords(url, search_engine)  
    
    # Search url make-up:
    # => [stuff][query_string]=[keyword_string]&[other_stuff]
    # Keywords are separated by %20 or +, these are converted to " " when unescaped.

    @engine_query_string = {
      :google => 'q',
      :bing => 'q',
      :yahoo => 'p',
      :msn => 'q',
      :aol => 'query',
      :ask => 'q',
      :yandex => 'text',
      :search => 'q'
    }
    
    @engine_query_string.each do |engine, query_string|
      return CGI.unescape(url.split(query_string+"=")[1].split("&")[0]) if search_engine == engine
    end
    
    return nil
    
  end
  
  def validate
    assert_present :page_id
  end
  
end