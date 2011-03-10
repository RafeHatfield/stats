class TrackingController < ApplicationController

  def add_page_view
    
    raw_page_view_data = {
      :suite101_article_id => params[:suite101_article_id],
      :permalink => params[:permalink],
      :title => params[:title],
      :writer_id  => params[:writer_id ],
      :referrer_url => params[:referrer_url],
      :cookie_id => params[:cookie_id],
      :date => params[:date]
    }
    
    if rand(3) == 1
      Resque.enqueue(RawPageViewJob, raw_page_view_data.to_json)
    end
    
    # Send a 1px image back to the requester.
    send_file 'public/images/page_view.gif'
  end

end
