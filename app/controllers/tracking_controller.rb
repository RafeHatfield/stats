class TrackingController < ApplicationController

  def add_page_view
    
    raw_page_view_data = {
      :suite101_article_id => params[:suite101_article_id],
      :permalink => params[:permalink],
      :title => params[:title],
      :writer_id  => params[:writer_id],
      :referrer_url => params[:referrer_url] || "",
      :cookie_id => params[:cookie_id],
      #:date => params[:utc_seconds] ? Time.at(params[:utc_seconds].to_i) : Time.now
      :date => Time.now
    }
    
    Resque.enqueue(RawPageViewJob, raw_page_view_data.to_json) if rand(10) == 1
    
    # Send a 1px image back to the requester.
    redirect_to 'http://graphics.suite101.com/page_view.gif'
  end

end
