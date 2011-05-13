require 'lib/date_partition.rb'

namespace :date_partition do
    
  # RAILS_ENV=production rake partition:create column=domain
  desc "Create partition table"
  task :create => :environment do
    partition = DatePartition.new(ENV['column'])
    
    partition.create_master_table
    
    puts "Creating partitioned tables"
    "01".upto("12") do |p|
      partition.create_partition_table(p)
    end
    
    puts "Creating and registering trigger function"
    partition.trigger
  end
  
  # RAILS_ENV=production rake partition:indices column=domain
  desc "Add indices for each partition"
  task :indices => :environment do
    partition = DatePartition.new(ENV['column'])
    
    puts "Adding indices to partitioned tables"
    "01".upto("12") do |month|
      partition.index_on_date_and_article_id(month)
      partition.index_on_date_and_writer_id(month)
      partition.index_on_column(month)
    end
  end
  
  # RAILS_ENV=production rake partition:drop_indices column=domain
  desc "Drop indices for each partition"
  task :drop_indices => :environment do
    partition = DatePartition.new(ENV['column'])
    
    puts "Dropping indices on partitioned tables"
    "01".upto("12") do |month|
      partition.drop_index_on_date_and_article_id(month)
      partition.drop_index_on_date_and_writer_id(month)
      partition.drop_index_on_column(month)
    end
  end
  
  
  # RAILS_ENV=production rake partition:drop column=domain
  desc "Create partition table"
  task :drop => :environment do
    partition = DatePartition.new(ENV['column'])
    puts "Drop master table #{partition.master_table}"
    partition.drop_tables
  end
  
end

