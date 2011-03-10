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
  def self.get_keywords(url, engine)  
    # Search url make-up:
    # => [junk]?[query]
    # => [junk]?[junk][search_key][raw_keyphrase]&[junk]

    search_key = {
      :google => 'q=',
      :bing => 'q=',
      :yahoo => 'p=',
      :msn => 'q=',
      :aol => 'query=',
      :ask => 'q=',
      :yandex => 'text=',
      :search => 'q='
    }
    
    if search_key.has_key?(engine)
      return nil
    end
    
    query = URI.parse(url).query
    
    if url.include?(search_key[engine])
      post_key = url.split(search_key[engine]).second
      raw_keyphrase = post_key.split("&").first
      # Keywords are separated by %20 or +, these are converted to " " when unescaped.
      return CGI.unescape(raw_keyphrase)
    else
      return nil
    end
  end
  
  def self.get_domain(url)
    URI.parse(url).host
  end
  
end