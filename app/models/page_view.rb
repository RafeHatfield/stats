class PageView < Ohm::Model
  include Ohm::Boundaries
  
  reference :page, Page
    
  attribute :visited_at
  attribute :referer_url
  attribute :cookie_id

  index :cookie_id  
  # check out the ohm extension at http://labs.sinefunc.com/ohm-contrib/doc/ and https://github.com/sinefunc/ohm-contrib  


  # Given a natural search engine search url return the search engine
  # Return nil if we don't match any search engine.
  def self.get_search_engine(url)
    @engine_regex = {
      :google => /google\..*\?/,
      :yahoo => /yahoo\..*\?/,
      :bing => /bing\..*\?/,
      :msn => /msn\..*\?/,
      :aol => /aol\..*\?/,
      :ask => /ask\..*\?/,
      :yandex => /yandex\..*\?/,
      :search => /search\..*\?/
    }
                 
    @engine_regex.each do |engine, regex|
      if (regex.match(url))
         return engine
      end
    end
  
    return nil
  end

  # Given a search url and a valid engine symbol return an array of the search keywords
  # If the engine symbol is not valid then return nil
  def self.get_keywords(url, search_engine)
    # For google and bing the keywords are after the "?q=" and before the first "&". They are separated by "+".
    # For yahoo its the same but uses "?p="
    
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
      if( search_engine == engine )
        return CGI.unescape(url.split(query_string+"=")[1].split("&")[0]).split(' ')
      end
    end
    
    return nil
  end
  
end