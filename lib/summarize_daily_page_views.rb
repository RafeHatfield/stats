require 'ruby-debug'

# Get highest date from summary
most_recently_processed = DailyTotalView.order("date DESC").limit(1)

if !most_recently_processed.empty?
  date_to_process = most_recently_processed.date + 1.day
else
  date_to_process = Date.parse("2011-02-01").to_date
end

if date_to_process < 2.days.ago.to_date
  
  puts "Processing date #{date_to_process}."
  
  total_views = DailyPageView.summarize_by_date(date_to_process)
  if !total_views.nil?
    puts "Inserting #{total_views} as total_views on #{date_to_process}."
    DailyTotalView.create(:total_views => total_views, :date => date_to_process)
  else
    puts "No views on this day, inserting 0."
    DailyTotalView.create(:total_views => 0, :date => date_to_process)
  end
    

end


