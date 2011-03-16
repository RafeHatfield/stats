namespace :dev_seeds do  

  WRITER_ID = 1
  ARTICLES = [
    {:id => 11111, :title => "Article 1", :writer_id => WRITER_ID},
    {:id => 22222, :title => "Article 2", :writer_id => WRITER_ID},
    {:id => 33333, :title => "Article 3", :writer_id => WRITER_ID}
  ]
  REFERRER_URLS = [
    "http://www.google.ca/search?q=awesome+sauce&ie=utf-8&oe=utf-8&aq=t&rls=org.mozilla:en-US:official&client=firefox-a",
    "http://www.google.ca/search?q=happy+dogs&ie=utf-8&oe=utf-8&aq=t&rls=org.mozilla:en-US:official&client=firefox-a",
    "http://www.bing.com/search?q=awesome+sauce&x=0&y=0&form=MSNH14&qs=n&sk=",
    "http://www.google.com/search?q=awesome&ie=utf-8&oe=utf-8&aq=t&rls=org.mozilla:en-US:official&client=firefox-a",
    "http://www.google.com/search?q=awesome+sauce&ie=utf-8&oe=utf-8&aq=t&rls=org.mozilla:en-US:official&client=firefox-a",
    "http://www.bing.com/search?q=awesome&x=0&y=0&form=MSNH14&qs=n&sk=",
    "",
    "",
    "http://www.happyplanet.net/ten-great-articles-you-should-read",
    "http://www.suite101.com/my_article_that_i_wrote",
    "http://my.suite101.de/my_article_that_i_wrote"
  ]

  desc "Cleanup the development database"
  task :cleanup => :environment do
    puts "Cleaning up the test data..."
    ARTICLES.each do |article|
      Article.where(:suite101_article_id => article[:id]).destroy_all
    end
    puts 'done.'
  end

  desc "Inject test data for development environment"
  task :fill => [:cleanup, :environment] do
    puts 'Hardcore populating action...'
    ARTICLES.each do |article|
      REFERRER_URLS.each do |referrer_url|
        90.downto(0) do |i_day|
          count = (6.*Math.sin(i_day*(360/6.28))).to_i + 6 + rand(4)
          count.times do
            RawPageViewJob.perform(
              {
                :writer_id => article[:writer_id],
                :cookie_id => "arandomcookie",
                :permalink => "http://www.suite101.com/content/chocolate-has-an-expiration-date-a347637",
                :suite101_article_id => article[:id],
                :referrer_url => referrer_url,
                :title => article[:title],
                :date => i_day.days.ago,
                :cookie_id => "#{1000 + rand(1000000)}"
              }.to_json
            )
          end
          puts "Registered #{count} views on article #{article[:id]} for member #{article[:writer_id]} on #{i_day.days.ago.to_date}."
        end
      end
    end
    puts "Done..."
  end

  # desc "Inject i18n test data for development environment"
  #   task :fill_i18n => [:cleanup, :environment] do
  #     puts 'Hardcore international populating action...'
  #     
  #     writer_id = WRITER_ID
  #     
  #     domain_extension = [:com, :de, :fr, :net]
  #             
  #     90.downto(0) do |i|
  #       domain = domain_extension[rand(3)]
  #       url = "http://www.suite101.#{domain}/content/chocolate-has-an-expiration-date-a347637"
  #       ref_url = "http://www.google.ca/search?q=awesome+sauce&ie=utf-8&oe=utf-8&aq=t&rls=org.mozilla:en-US:official&client=firefox-a"
  #       
  #       raw_page_view_data = {
  #         :suite101_article_id => i,
  #         :permalink => url,
  #         :title => "Article #{i}",
  #         :writer_id  => writer_id,
  #         :referrer_url => ref_url,
  #         :cookie_id => "randcookie#{i}",
  #         :date => i.days.ago
  #       }
  #       count = (6.*Math.sin(i*(360/6.28))).to_i + 6 + rand(4)
  #       count.times do
  #         RawPageViewJob.perform(raw_page_view_data.to_json)
  #       end
  #       puts "Registered #{count} views on article #{raw_page_view_data[:suite101_article_id]} for writer #{writer_id} on #{raw_page_view_data[:date].to_date}."
  #     end
  #     
  #   end
end
