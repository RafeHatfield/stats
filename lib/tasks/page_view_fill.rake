task :page_view_fill => :environment do

  writer_id = 888

  DailyPageView.where(:writer_id => writer_id).delete_all

  article_data = [["Article 1", 1111], ["Article 2", 2222], ["Article 3", 3333]]

  article_data.each do |data|
 
    article = Article.find_and_update_title_or_create({
        :suite101_article_id => data[1],
        :writer_id => writer_id,
        :title => data[0],
        :permalink => "http://www.google.ca"
      })
    
    90.downto(0) do |i|
      date = i.days.ago
      count = (6.*Math.sin(i*(360/6.28))).to_i + 6 + rand(4)
      count.times do
        article.increment_page_view_on(date)
      end
      puts "On #{date} added #{count} page views to #{article.suite101_article_id}"
    end
    
  end 
end