class WriterPartition
  PARTITION_SIZE = 41
  
  def initialize(column)
    raise 'No column name specified!' if column.blank?
    
    @column = column
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
    cmd = <<-COMMAND
      CREATE OR REPLACE FUNCTION writers_#{@column}_trigger() 
      RETURNS TRIGGER AS $$ 
      DECLARE
        ins_sql TEXT; 
      BEGIN
        ins_sql := 'INSERT INTO daily_#{@column}_views_' || (NEW.writer_id % #{PARTITION_SIZE}) ||
          '(date,article_id,#{@column},count,writer_id) 
          VALUES ' ||
          '('|| quote_literal(NEW.date) || ',' || NEW.article_id ||',' ||
          	quote_literal(NEW.#{@column}) || ',' || 
      			NEW.count || ',' || 
      			NEW.writer_id || ')'
          ; 
        EXECUTE ins_sql;
        RETURN NULL;
      END; 
      $$
      LANGUAGE plpgsql;
      
      CREATE TRIGGER insert_#{@column}_trigger
          BEFORE INSERT ON daily_#{@column}_views_master
          FOR EACH ROW EXECUTE PROCEDURE writers_#{@column}_trigger();
    COMMAND
    @conn.exec(cmd)
  end
    
  def create_master_table
    cmd = <<-COMMANDS
      CREATE TABLE daily_#{@column}_views_master
      (
        id serial NOT NULL,
        date date,
        article_id integer,
        "#{@column}" character varying(255),
        count integer,
        writer_id integer,
        created_at timestamp without time zone,
        updated_at timestamp without time zone,
        CONSTRAINT daily_#{@column}_views_master_pkey PRIMARY KEY (id)
      )
      WITH (
        OIDS=FALSE
      );
      ALTER TABLE daily_#{@column}_views OWNER TO #{@owner};
    COMMANDS
    @conn.exec(cmd)
  end
  
  def create_partition_tables
    0.upto(PARTITION_SIZE - 1) do |p|
      cmd = "CREATE TABLE daily_#{@column}_views_#{p}( ) INHERITS (#{master_table});"
      @conn.exec(cmd)
    end
  end
  
  def add_indices
    0.upto(PARTITION_SIZE - 1) do |index|
      index_on_article_id_and_date(index)
      index_on_writer_id_and_date(index)
      index_on_keyphrase(index)
    end
  end
  
  def drop_indices
    0.upto(PARTITION_SIZE - 1) do |index|
      drop_index_on_article_id_and_date(index)
      drop_index_on_writer_id_and_date(index)
      drop_index_on_column(index)
    end
  end
  
  def index_on_article_id_and_date(index)
    cmd = <<-COMMANDS
      CREATE INDEX index_daily_#{@column}_views_#{index}_on_article_id_n_date
        ON daily_#{@column}_views_#{index}
        USING btree
        (article_id, date DESC);
    COMMANDS
    @conn.exec(cmd)
  end
    
  def index_on_writer_id_and_date(index)
    cmd = <<-COMMANDS
      CREATE INDEX index_daily_#{@column}_views_#{index}_on_writer_id_n_date
        ON daily_#{@column}_views_#{index}
        USING btree
        (writer_id, date DESC);
    COMMANDS
    @conn.exec(cmd)
  end

  def index_on_keyphrase(index)
    cmd = <<-COMMANDS
      CREATE INDEX index_daily_#{@column}_views_#{index}_on_#{@column}
        ON daily_#{@column}_views_#{index}
        USING btree
        (#{@column});
    COMMANDS
    @conn.exec(cmd)
  end
  
  def drop_index_on_article_id_and_date(index)
    cmd = <<-COMMANDS
      DROP INDEX IF EXISTS index_daily_#{@column}_views_#{index}_on_article_id_n_date;
    COMMANDS
    @conn.exec(cmd)
  end
  
  def drop_index_on_writer_id_and_date(index)
    cmd = <<-COMMANDS
      DROP INDEX IF EXISTS index_daily_#{@column}_views_#{index}_on_writer_id_n_date;
    COMMANDS
    @conn.exec(cmd)
  end
  
  def drop_index_on_column(index)
    cmd = <<-COMMANDS
      DROP INDEX IF EXISTS index_daily_#{@column}_views_#{index}_on_#{@column};
    COMMANDS
    @conn.exec(cmd)
  end
  
  def drop_tables
    cmd = "Drop TABLE IF EXISTS #{master_table} CASCADE;"
    @conn.exec(cmd)
  end
  
end