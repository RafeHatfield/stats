class PageView < Ohm::Model
  include Ohm::Boundaries
  include Ohm::Callbacks
  
  reference :page, Page
    
  attribute :visited_at
  attribute :referer_url
  attribute :cookie_id
  attribute :keyword_phrase
  attribute :search_engine

  index :cookie_id  
  # check out the ohm extension at http://labs.sinefunc.com/ohm-contrib/doc/ and https://github.com/sinefunc/ohm-contrib  

  before :save, :save_keywords_and_search_engine

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
  
  protected
  
  def save_keywords_and_search_engine
    # Determine the keyword phrase and search engine for this
    # referrer url if the referrer is from a search engine

    search_engine = PageView.get_search_engine(self.referer_url)
  
    if search_engine
      keyword_phrase = PageView.get_keywords(self.referer_url, search_engine)
    else
      keyword_phrase = nil
    end
  
    self.keyword_phrase = keyword_phrase
    self.search_engine = search_engine.to_s
  end
  
  
end