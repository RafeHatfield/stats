require 'lib/writer_partition.rb'

namespace :writer_partition do
    
  # RAILS_ENV=production rake writer_partition:create column=domain
  desc "Create partition table"
  task :create => :environment do
    partition = WriterPartition.new(ENV['column'])
    
    puts "Creating master partition table #{partition.master_table}"
    partition.create_master_table
    
    puts "Creating partitioned tables"
    partition.create_partition_tables
    
    puts "Creating trigger function"
    partition.trigger    
  end
  
  # rake writer_partition:indices column=domain
  desc "Add indices for each partition"
  task :indices => :environment do
    partition = WriterPartition.new(ENV['column'])
    
    puts "Adding indices to partitioned tables"
    partition.add_indices
  end
  
  # rake writer_partition:drop_indices column=domain
  desc "Drop indices for each partition"
  task :drop_indices => :environment do
    partition = WriterPartition.new(ENV['column'])
    
    puts "Dropping indices on partitioned tables"
    partition.drop_indices
  end
  
  
  # rake writer_partition:drop column=domain
  desc "Create partition table"
  task :drop => :environment do
    partition = WriterPartition.new(ENV['column'])
    
    puts "Drop master table #{partition.master_table}"
    partition.drop_tables
  end
  
end

