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

  protected
  
  # If the referrer_url is from a supported search engine
  # determine the search engine and keyword phrase and
  # save these with the page view.
  def save_keywords_and_search_engine
    search_engine = SearchURLParser.get_search_engine(self.referer_url)
  
    if search_engine
      keyword_phrase = SearchURLParser.get_keywords(self.referer_url, search_engine)
    else
      keyword_phrase = nil
    end
  
    self.keyword_phrase = keyword_phrase
    self.search_engine = search_engine.to_s
  end
  
  
end