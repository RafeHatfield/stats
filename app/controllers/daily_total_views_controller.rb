class DailyTotalViewsController < ApplicationController

  def index
    @daily_total_views = DailyTotalView.where("date >= '#{92.days.ago.to_date}'")
    respond_to do |format|
      format.xml # index.xml.builder
    end
  end

end
