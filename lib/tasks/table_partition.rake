require 'lib/writer_partition.rb'

namespace :partition do
  PARTITION_SIZE = 41
  include WriterPartition
  
  def get_db_connection
    config = YAML.load_file("#{Rails.root.to_s}/config/database.yml")[Rails.env]
    @owner = config["username"]
    conn = PGconn.new(config["host"], config["port"], '', '', config["database"], @owner, config["password"])
    conn
  end
  
  # RAILS_ENV=production rake partition:create column=domain
  desc "Create partition table"
  task :create => :environment do
    conn = get_db_connection
    column = ENV['column']
    
    master_table = "daily_#{column}_views_master"
    
    puts "Creating master partition table #{master_table}"
    conn.exec(create_master_table(column))
    
    puts "Creating partitioned tables"
    0.upto(PARTITION_SIZE - 1) do |partition|
      conn.exec(create_partition_table(column, partition, master_table))
    end
    
    puts "Creating trigger function"
    conn.exec(trigger(column))
    
    puts "Registering trigger function"
    conn.exec(register_trigger(column))
  end
  
  # rake partition:indices column=domain
  desc "Add indices for each partition"
  task :indices => :environment do
    conn = get_db_connection
    column = ENV['column']
    
    puts "Adding indices to partitioned tables"
    0.upto(PARTITION_SIZE - 1).each_with_index do |index, partition|
      conn.exec(index_on_article_id_and_date(index, column))
      conn.exec(index_on_writer_id_and_date(index, column))
      conn.exec(index_on_keyphrase(index, column))
    end
  end
  
  # rake partition:drop_indices column=domain
  desc "Drop indices for each partition"
  task :drop_indices => :environment do
    conn = get_db_connection
    column = ENV['column']
    
    puts "Dropping indices on partitioned tables"
    0.upto(PARTITION_SIZE - 1).each_with_index do |index, partition|
      conn.exec(drop_index_on_article_id_and_date(index, column))
      conn.exec(drop_index_on_writer_id_and_date(index, column))
      conn.exec(drop_index_on_keyphrase(index, column))
    end
  end
  
  
  # rake partition:drop column=domain
  desc "Create partition table"
  task :drop => :environment do
    conn = get_db_connection
    column = ENV['column']
    
    master_table = "daily_#{column}_views_master"
    puts "Drop master table #{master_table}"
    conn.exec("Drop TABLE IF EXISTS #{master_table} CASCADE;")    
  end
  
end

