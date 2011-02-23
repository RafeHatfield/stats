class TrackingController < ApplicationController

  #  id              :integer         not null, primary key
  #  tracked_page_id :integer
  #  page_url        :string(255)
  #  page_title      :string(255)
  #  writer_id       :integer
  #  referrer_url    :string(255)
  #  cookie_id       :string(255)
  #  visited_at      :datetime
  #

  def add_page_view
    
    # Create a new page view
    RawPageView.create({
      :tracked_page_id => params[:tracked_page_id],
      :page_url => params[:page_url],
      :page_title => params[:page_title],
      :writer_id  => params[:writer_id ],
      :referrer_url => params[:referrer_url],
      :cookie_id => params[:cookie_id],
      :visited_at => params[:visited_at]
    })
    
    # Send a 1px image back to the requester.
    send_file 'public/images/page_view.gif'
  end

end