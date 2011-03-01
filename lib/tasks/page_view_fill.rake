task :page_view_fill => :environment do

 article = Article.find_and_update_title_or_create({
    :suite101_article_id => 777,
    :writer_id => 888,
    :title => "My article",
    :permalink => "http://www.google.ca"
  })

 90.downto(0) do |i|
   date = i.days.ago
   count = rand(5)
   count.times do
     article.increment_page_view_on(date)
   end
   puts "On #{date} added #{count} page views to #{article.suite101_article_id}"
 end
 
end