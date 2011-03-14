namespace :db do
  desc "Create sharding databases"
  task :create_shards => :environment do
    puts 'Creating database shards...'
    conn = PGconn.new('localhost', 5432, '', '', '', 'postgres', '')
    config = YAML.load_file("#{Rails.root.to_s}/config/shards.yml")['octopus'][RAILS_ENV]
    shards = config.keys
    shards.each do |shard|
      database = config[shard]['database']
      conn.exec("DROP DATABASE IF EXISTS #{database};")
      conn.exec("CREATE DATABASE #{database};")
      puts "created database shard: #{database}"
    end
    puts "done."
  end
end