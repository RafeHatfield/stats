task :page_view_fill => :environment do
  writer_id = 655428
  RawPageView.where(:writer_id => writer_id).delete_all
  DailyPageView.where(:writer_id => writer_id).delete_all
  DailyKeyphraseView.where(:writer_id => writer_id).delete_all
  Article.where(:suite101_article_id => 1111).delete_all
  Article.where(:suite101_article_id => 2222).delete_all
  Article.where(:suite101_article_id => 3333).delete_all

  pv_template = {
    :writer_id => writer_id,
    :cookie_id => "arandomcookie",
    :permalink => "http://www.suite101.com/content/chocolate-has-an-expiration-date-a347637"
  }
  pv_data = []
  pv_data << pv_template.merge(:title => "Article 1", :suite101_article_id => 1111)
  pv_data << pv_template.merge(:title => "Article 2", :suite101_article_id => 2222)
  pv_data << pv_template.merge(:title => "Article 3", :suite101_article_id => 3333)
  
  referrer_urls = []
  referrer_urls << "http://www.google.ca/search?q=awesome+sauce&ie=utf-8&oe=utf-8&aq=t&rls=org.mozilla:en-US:official&client=firefox-a"
  referrer_urls << "http://www.google.ca/search?q=happy+dogs&ie=utf-8&oe=utf-8&aq=t&rls=org.mozilla:en-US:official&client=firefox-a"
  referrer_urls << "http://www.google.ca/search?q=awesome&ie=utf-8&oe=utf-8&aq=t&rls=org.mozilla:en-US:official&client=firefox-a"
  referrer_urls << "http://www.google.ca/search?q=awesome&ie=utf-8&oe=utf-8&aq=t&rls=org.mozilla:en-US:official&client=firefox-a"
  
  pv_data.each do |data|
    90.downto(0) do |i|
      data[:date] = i.days.ago
      count = (6.*Math.sin(i*(360/6.28))).to_i + 6 + rand(4)
      count.times do
        data[:referrer_url] = referrer_urls[rand(3)]
        RawPageViewJob.process_raw_page_view(RawPageView.create!(data))
      end
      puts "Registered #{count} views on article #{data[:suite101_article_id]} for member #{writer_id} on #{data[:date].to_date}."
    end
    
  end

  # 
  # article_data = [["Article 1", 1111], ["Article 2", 2222], ["Article 3", 3333]]
  # 
  # article_data.each do |data|
  #  
  #   article = Article.find_and_update_title_or_create({
  #       :suite101_article_id => data[1],
  #       :writer_id => writer_id,
  #       :title => data[0],
  #       :permalink => "http://www.google.ca"
  #     })
  #   
  #   90.downto(0) do |i|
  #     date = i.days.ago
  #     count = (6.*Math.sin(i*(360/6.28))).to_i + 6 + rand(4)
  #     count.times do
  #       article.increment_page_view_on(date)
  #     end
  #     puts "On #{date} added #{count} page views to #{article.suite101_article_id}"
  #   end
  #   
  # end
  # 
  # 
  # writer_id = 888
  # 
  # DailyPageView.where(:writer_id => writer_id).delete_all
  # 
  # article_data = [["Article 1", 1111], ["Article 2", 2222], ["Article 3", 3333]]
  # 
  # article_data.each do |data|
  #  
  #   article = Article.find_and_update_title_or_create({
  #       :suite101_article_id => data[1],
  #       :writer_id => writer_id,
  #       :title => data[0],
  #       :permalink => "http://www.google.ca"
  #     })
  #   
  #   90.downto(0) do |i|
  #     date = i.days.ago
  #     count = (6.*Math.sin(i*(360/6.28))).to_i + 6 + rand(4)
  #     count.times do
  #       article.increment_page_view_on(date)
  #     end
  #     puts "On #{date} added #{count} page views to #{article.suite101_article_id}"
  #   end
  #   
  # end 
end