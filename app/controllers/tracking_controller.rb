class TrackingController < ApplicationController

  def add_page_view
    
    raw_page_view_data = {
      :tracked_page_id => params[:tracked_page_id],
      :page_url => params[:page_url],
      :page_title => params[:page_title],
      :writer_id  => params[:writer_id ],
      :referrer_url => params[:referrer_url],
      :cookie_id => params[:cookie_id],
      :visited_at => params[:visited_at]
    }
    
    # Create a new page view
    RawPageView.create(raw_page_view_data)
    
    # Send a 1px image back to the requester.
    send_file 'public/images/page_view.gif'
  end

end
