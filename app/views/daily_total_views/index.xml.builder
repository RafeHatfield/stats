xml.instruct!
xml.root do
  @daily_total_views.each do |daily_total_view|
    xml.item daily_total_view.total_views
  end
end