class RawPageViewJob
  @queue = :page_view

  def self.perform(raw_page_view_data)
    # Create a new page view
    hash = ActiveSupport::JSON.decode(raw_page_view_data)
    RawPageView.create(hash)
  end
  
end