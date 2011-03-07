class SearchUrlParser
# Class to handle parsing of search engine and keywords from a search url.
  
  # Given a natural search engine search url return the search engine.
  # If we don't match any search engine, return nil.
  def self.get_search_engine(url)
    
    # Match "engine_name" followed by a "." with a "?" after it.
    # NOTE: Search.com matching must be last because other engines
    #       use "search." in their domain and we want to catch them first.
    
    engine_regex = {
      :google => /google\..*\?/,
      :yahoo => /yahoo\..*\?/,
      :bing => /bing\..*\?/,
      :msn => /msn\..*\?/,
      :aol => /aol\..*\?/,
      :ask => /ask\..*\?/,
      :yandex => /yandex\..*\?/,
      :search => /www\.search\.com.*\?/
    }
                 
    engine_regex.each do |engine, regex|
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

    engine_query_string = {
      :google => 'q',
      :bing => 'q',
      :yahoo => 'p',
      :msn => 'q',
      :aol => 'query',
      :ask => 'q',
      :yandex => 'text',
      :search => 'q'
    }
    
    query_string = engine_query_string[search_engine] + "="
    
    if url.include?(query_string)
      post_query_string = url.split(query_string).second
      keyword_string = post_query_string.split("&").first
      return CGI.unescape(keyword_string)
    else
      return nil
    end
  end
  
end