namespace :migrate do
  desc "Import CSV files into database"
  task :writers => :environment do
    count = 0.0
    articles = Article.all
    size = articles.size
    pbar = ProgressBar.new("Migrating writers...", 100)
    time = Benchmark.realtime do
      articles.each do |a|
        Writer.instance.writer_ids << a.writer_id
        percentage = (count += 1)/size * 100
        pbar.set percentage
      end
      pbar.finish
    end
    puts "done. Time elapsed #{time} seconds"
  end
end