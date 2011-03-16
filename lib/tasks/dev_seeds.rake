namespace :dev_seeds do  
  desc "Cleanup the development database"
  task :cleanup => :environment do
    puts "Cleaning up the test data..."
    writer_id = 1
    Article.where(:suite101_article_id => [11111,22222,33333]).destroy_all
    puts 'done.'
  end
    
  desc "Inject test data for development environment"
  task :fill_page_views => [:cleanup, :environment] do
    puts 'Hardcore populating action...'
    
    writer_id = 1
    
    pv_template = {
      :writer_id => writer_id,
      :cookie_id => "arandomcookie",
      :permalink => "http://www.suite101.com/content/chocolate-has-an-expiration-date-a347637"
    }
    pv_data = []
    pv_data << pv_template.merge(:title => "Article 1", :suite101_article_id => 11111)
    pv_data << pv_template.merge(:title => "Article 2", :suite101_article_id => 22222)
    pv_data << pv_template.merge(:title => "Article 3", :suite101_article_id => 33333)

    referrer_urls = []
    referrer_urls << "http://www.google.ca/search?q=awesome+sauce&ie=utf-8&oe=utf-8&aq=t&rls=org.mozilla:en-US:official&client=firefox-a"
    referrer_urls << "http://www.google.ca/search?q=happy+dogs&ie=utf-8&oe=utf-8&aq=t&rls=org.mozilla:en-US:official&client=firefox-a"
    referrer_urls << "http://www.bing.com/search?q=awesome+sauce&x=0&y=0&form=MSNH14&qs=n&sk="
    referrer_urls << "http://www.google.com/search?q=awesome&ie=utf-8&oe=utf-8&aq=t&rls=org.mozilla:en-US:official&client=firefox-a"
    referrer_urls << "http://www.google.com/search?q=awesome+sauce&ie=utf-8&oe=utf-8&aq=t&rls=org.mozilla:en-US:official&client=firefox-a"
    referrer_urls << "http://www.bing.com/search?q=awesome&x=0&y=0&form=MSNH14&qs=n&sk="
    referrer_urls << ""
    referrer_urls << ""
    referrer_urls << "http://www.happyplanet.net/ten-great-articles-you-should-read"
    referrer_urls << "http://www.suite101.com/my_article_that_i_wrote"
    referrer_urls << "http://my.suite101.de/my_article_that_i_wrote"

    pv_data.each do |data|
      90.downto(0) do |i|
        data[:date] = i.days.ago
        count = (6.*Math.sin(i*(360/6.28))).to_i + 6 + rand(4)
        count.times do
          data[:referrer_url] = referrer_urls[rand(11)]
          RawPageViewJob.process_raw_page_view(RawPageView.create!(data))
        end
        puts "Registered #{count} views on article #{data[:suite101_article_id]} for member #{writer_id} on #{data[:date].to_date}."
      end
    end
  end
  
  desc "Inject i18n test data for development environment"
  task :fill_i18n_page_views => [:cleanup, :environment] do
    puts 'Hardcore international populating action...'
    
    writer_id = 1
    
    domain_extension = [:com, :de, :fr, :net]
            
    90.downto(0) do |i|
      domain = domain_extension[rand(3)]
      url = "http://www.suite101.#{domain}/content/chocolate-has-an-expiration-date-a347637"
      ref_url = "http://www.google.ca/search?q=awesome+sauce&ie=utf-8&oe=utf-8&aq=t&rls=org.mozilla:en-US:official&client=firefox-a"
      
      raw_page_view_data = {
        :suite101_article_id => i,
        :permalink => url,
        :title => "Article #{i}",
        :writer_id  => writer_id,
        :referrer_url => ref_url,
        :cookie_id => "randcookie#{i}",
        :date => i.days.ago
      }
      count = (6.*Math.sin(i*(360/6.28))).to_i + 6 + rand(4)
      count.times do
        RawPageViewJob.perform(raw_page_view_data.to_json)
      end
      puts "Registered #{count} views on article #{raw_page_view_data[:suite101_article_id]} for writer #{writer_id} on #{raw_page_view_data[:date].to_date}."
    end
    
  end
end
