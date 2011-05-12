namespace :partition do
  PARTITION_SIZE = 41
  
  def get_db_connection
    config = YAML.load_file("#{Rails.root.to_s}/config/database.yml")[Rails.env]
    @owner = config["username"]
    conn = PGconn.new(config["host"], config["port"], '', '', config["database"], @owner, config["password"])
    conn
  end
  
  # column can be
  # keyphrase, domain, or page
  def trigger(column)
    <<-COMMAND
      CREATE OR REPLACE FUNCTION writers_#{column}_trigger() 
      RETURNS TRIGGER AS $$ 
      DECLARE
        ins_sql TEXT; 
      BEGIN
        ins_sql := 'INSERT INTO daily_#{column}_views_' || (NEW.writer_id % 41) ||
          '(date,article_id,#{column},count,writer_id) 
          VALUES ' ||
          '('|| quote_literal(NEW.date) || ',' || NEW.article_id ||',' ||
          	quote_literal(NEW.#{column}) || ',' || 
      			NEW.count || ',' || 
      			NEW.writer_id || ')'
          ; 
        EXECUTE ins_sql;
        RETURN NULL;
      END; 
      $$
      LANGUAGE plpgsql;
    COMMAND
  end
  
  def register_trigger(column)
    <<-COMMAND
      CREATE TRIGGER insert_#{column}_trigger
          BEFORE INSERT ON daily_#{column}_views
          FOR EACH ROW EXECUTE PROCEDURE writers_#{column}_trigger();
    COMMAND
  end
  
  def create_master_table(column)
    <<-COMMANDS
      CREATE TABLE daily_#{column}_views_master
      (
        id serial NOT NULL,
        date date,
        article_id integer,
        "#{column}" character varying(255),
        count integer,
        writer_id integer,
        created_at timestamp without time zone,
        updated_at timestamp without time zone,
        CONSTRAINT daily_#{column}_views_master_pkey PRIMARY KEY (id)
      )
      WITH (
        OIDS=FALSE
      );
      ALTER TABLE daily_#{column}_views OWNER TO #{@owner};
    COMMANDS
  end
  
  def index_on_article_id_and_date(index, column)
    <<-COMMANDS
      CREATE INDEX index_daily_#{column}_views_#{index}_on_article_id_n_date
        ON daily_#{column}_views_#{index}
        USING btree
        (article_id, date DESC);
    COMMANDS
  end
    
  def index_on_writer_id_and_date(index, column)
    <<-COMMANDS
      CREATE INDEX index_daily_#{column}_views_#{index}_on_writer_id_n_date
        ON daily_#{column}_views_#{index}
        USING btree
        (writer_id, date DESC);
    COMMANDS
  end
  
  def drop_index_on_article_id_and_date(index, column)
    <<-COMMANDS
      DROP INDEX IF EXISTS index_daily_#{column}_views_p#{index}_on_article_id_n_date;
    COMMANDS
  end
  
  def drop_index_on_writer_id_and_date(index, column)
    <<-COMMANDS
      DROP INDEX IF EXISTS index_daily_#{column}_views_p#{index}_on_writer_id_n_date;
    COMMANDS
  end
  
  def drop_index_on_keyphrase(index, column)
    <<-COMMANDS
      DROP INDEX IF EXISTS index_daily_#{column}_views_p#{index}_on_keyphrase;
    COMMANDS
  end
  
  
  # rake partition:create column=domain
  desc "Create partition table"
  task :create => :environment do
    conn = get_db_connection
    column = ENV['column']
    
    master_table = "daily_#{column}_views_master"
    
    puts "Creating master partition table #{master_table}"
    conn.exec(create_master_table(column))
    
    puts "Creating partitioned tables"
    0.upto(PARTITION_SIZE - 1) do |partition|
      conn.exec("CREATE TABLE daily_#{column}_views_#{partition}( ) INHERITS (#{master_table});")
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
    
    master_table = "daily_#{column}_views_main"
    puts "Drop master table #{master_table}"
    conn.exec("Drop TABLE IF EXISTS #{master_table} CASCADE;")    
  end
  
end

