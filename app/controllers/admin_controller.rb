class AdminController < ApplicationController
  def index
    @raw_page_views = RawPageView.all
  end
end
