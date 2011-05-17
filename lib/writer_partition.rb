class WriterPartition
  
  def initialize(column, partition_size)
    raise 'No column name specified!' if column.blank?
    
    @column = column
    @partition_size = partition_size
    config = YAML.load_file("#{Rails.root.to_s}/config/database.yml")[Rails.env]
    @owner = config["username"]
    @conn = PGconn.new(config["host"], config["port"], '', '', config["database"], @owner, config["password"])
  end
  
  def master_table
    "daily_#{@column}_views_master"
  end
  
  # column can be
  # keyphrase, domain, or page
  def trigger
    trigger_function = "insert_#{master_table}"
    unless @column == 'page'
      column = "#{@column},"
      column_function = "coalesce(quote_literal(NEW.#{@column}), 'NULL') || ',' ||"
    end
    
    cmd = <<-COMMAND
      CREATE OR REPLACE FUNCTION #{trigger_function}() 
      RETURNS TRIGGER AS $$ 
      DECLARE
        ins_sql TEXT; 
      BEGIN
        ins_sql := 'INSERT INTO daily_#{@column}_views_' || (NEW.writer_id % #{@partition_size}) ||
          '(date,article_id,#{column}count,writer_id,partition_id) 
          VALUES ' ||
          '('|| quote_literal(NEW.date) || ',' || NEW.article_id ||',' ||
          	#{column_function} 
      			NEW.count || ',' || 
      			NEW.writer_id || ',' || (NEW.writer_id % #{@partition_size}) ||')'
          ; 
        EXECUTE ins_sql;
        RETURN NULL;
      END; 
      $$
      LANGUAGE plpgsql;
      
      CREATE TRIGGER #{trigger_function}_trigger
          BEFORE INSERT ON #{master_table}
          FOR EACH ROW EXECUTE PROCEDURE #{trigger_function}();
    COMMAND
    @conn.exec(cmd)
  end
      
  def create_master_table
    unless @column == 'page'
      column = "#{@column} character varying(255),"
    end
    
    cmd = <<-COMMANDS
      CREATE TABLE #{master_table}
      (
        id serial NOT NULL,
        date date,
        article_id integer,
        #{column}
        count integer,
        writer_id integer,
        created_at timestamp without time zone,
        updated_at timestamp without time zone,
        partition_id integer,
        CONSTRAINT #{master_table}_pkey PRIMARY KEY (id)
      )
      WITH (
        OIDS=FALSE
      );
      ALTER TABLE #{master_table} OWNER TO #{@owner};
    COMMANDS
    
    @conn.exec(cmd)
  end
  
  def create_partition_tables
    0.upto(@partition_size - 1) do |p|
      cmd = "CREATE TABLE daily_#{@column}_views_#{p}( ) INHERITS (#{master_table});"
      @conn.exec(cmd)
    end
  end
  
  def add_indices
    0.upto(@partition_size - 1) do |index|
      index_on_article_id_and_date(index)
      index_on_writer_id_and_date(index)
      index_on_keyphrase(index)
    end
  end
  
  def drop_indices
    0.upto(@partition_size - 1) do |index|
      drop_index_on_article_id_and_date(index)
      drop_index_on_writer_id_and_date(index)
      drop_index_on_column(index)
    end
  end
  
  def index_on_article_id_and_date(index)
    cmd = <<-COMMANDS
      CREATE INDEX index_#{master_table}_#{index}_on_article_id_n_date
        ON daily_#{@column}_views_#{index}
        USING btree
        (article_id, date DESC);
    COMMANDS
    @conn.exec(cmd)
  end
    
  def index_on_writer_id_and_date(index)
    cmd = <<-COMMANDS
      CREATE INDEX index_#{master_table}_#{index}_on_writer_id_n_date
        ON daily_#{@column}_views_#{index}
        USING btree
        (writer_id, date DESC);
    COMMANDS
    @conn.exec(cmd)
  end

  def index_on_keyphrase(index)
    cmd = <<-COMMANDS
      CREATE INDEX index_#{master_table}_#{index}_on_#{@column}
        ON daily_#{@column}_views_#{index}
        USING btree
        (#{@column});
    COMMANDS
    @conn.exec(cmd)
  end
  
  def drop_index_on_article_id_and_date(index)
    cmd = <<-COMMANDS
      DROP INDEX IF EXISTS index_#{master_table}_#{index}_on_article_id_n_date;
    COMMANDS
    @conn.exec(cmd)
  end
  
  def drop_index_on_writer_id_and_date(index)
    cmd = <<-COMMANDS
      DROP INDEX IF EXISTS index_#{master_table}_#{index}_on_writer_id_n_date;
    COMMANDS
    @conn.exec(cmd)
  end
  
  def drop_index_on_column(index)
    cmd = <<-COMMANDS
      DROP INDEX IF EXISTS index_#{master_table}_#{index}_on_#{@column};
    COMMANDS
    @conn.exec(cmd)
  end
  
  def drop_tables
    puts "Dropping partitioned tables"
    drop_functions    
    # 0.upto(@partition_size - 1) do |p|
    #   cmd = "DROP TABLE IF EXISTS #{master_table}_#{p};"
    #   @conn.exec(cmd)
    # end
    cmd = "Drop TABLE IF EXISTS #{master_table} CASCADE;"
    @conn.exec(cmd)
  end
  
  def drop_functions
    cmd = <<-COMMANDS
      DROP TRIGGER IF EXISTS insert_#{master_table}_trigger on #{master_table};
      DROP TRIGGER IF EXISTS update_#{master_table}_trigger on #{master_table};
      
      DROP FUNCTION IF EXISTS insert_#{master_table}();
      DROP FUNCTION IF EXISTS update_#{master_table}();
    COMMANDS
    puts "Dropping triggers and functions"
    @conn.exec(cmd)
  end
  
  def live_migrate_trigger
    trigger_function = "update_#{master_table}"
    
    cmd = <<-COMMANDS
      CREATE OR REPLACE FUNCTION #{trigger_function}()
      RETURNS TRIGGER AS $$ 
      BEGIN
        DELETE FROM #{master_table} WHERE OLD.id=id; 
        INSERT INTO #{master_table} values(NEW.*); 
        RETURN NULL;
      END; 
      $$ 
      LANGUAGE plpgsql; 
      
      CREATE TRIGGER #{trigger_function}_trigger
        BEFORE UPDATE ON #{master_table}
        FOR EACH ROW EXECUTE PROCEDURE #{trigger_function}();
    COMMANDS
    @conn.exec(cmd)
  end
  
  def live_migrate
    cmd = <<-COMMANDS
      UPDATE #{master_table} SET id=id;      
    COMMANDS
    @conn.exec(cmd)
  end
  
  def migrate(start_date, end_date)
    unless @column == 'page'
      column = "#{@column},"
    end
    cmd = <<-COMMANDS
      INSERT INTO #{master_table}
      (date, article_id, #{column}count, writer_id)
      SELECT date, article_id, #{column} count, writer_id
      FROM daily_#{@column}_views
      WHERE date BETWEEN '#{start_date}' AND '#{end_date}';
    COMMANDS
    @conn.exec(cmd)
  end
  
end