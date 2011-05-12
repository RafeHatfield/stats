class DatePartition
  
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
      CREATE OR REPLACE FUNCTION date_#{@column}_trigger()
      RETURNS TRIGGER AS $$
      BEGIN
          IF ( NEW.date >= DATE '2011-01-01' AND NEW.date < DATE '2011-02-01' ) THEN
              INSERT INTO daily_#{@column}_views_2011_01 VALUES (NEW.*);
          ELSIF ( NEW.date >= DATE '2011-02-01' AND NEW.date < DATE '2011-03-01' ) THEN
              INSERT INTO daily_#{@column}_views_2011_02 VALUES (NEW.*);
          ELSIF ( NEW.date >= DATE '2011-03-01' AND NEW.date < DATE '2011-04-01' ) THEN
              INSERT INTO daily_#{@column}_views_2011_03 VALUES (NEW.*);
          ELSIF ( NEW.date >= DATE '2011-04-01' AND NEW.date < DATE '2011-05-01' ) THEN
              INSERT INTO daily_#{@column}_views_2011_04 VALUES (NEW.*);
          ELSIF ( NEW.date >= DATE '2011-05-01' AND NEW.date < DATE '2011-06-01' ) THEN
              INSERT INTO daily_#{@column}_views_2011_05 VALUES (NEW.*);
          ELSIF ( NEW.date >= DATE '2011-06-01' AND NEW.date < DATE '2011-07-01' ) THEN
              INSERT INTO daily_#{@column}_views_2011_06 VALUES (NEW.*);
          ELSIF ( NEW.date >= DATE '2011-07-01' AND NEW.date < DATE '2011-08-01' ) THEN
              INSERT INTO daily_#{@column}_views_2011_07 VALUES (NEW.*);
          ELSIF ( NEW.date >= DATE '2011-08-01' AND NEW.date < DATE '2011-09-01' ) THEN
              INSERT INTO daily_#{@column}_views_2011_08 VALUES (NEW.*);
          ELSIF ( NEW.date >= DATE '2011-09-01' AND NEW.date < DATE '2011-10-01' ) THEN
              INSERT INTO daily_#{@column}_views_2011_09 VALUES (NEW.*);
          ELSIF ( NEW.date >= DATE '2011-010-01' AND NEW.date < DATE '2011-11-01' ) THEN
              INSERT INTO daily_#{@column}_views_2011_10 VALUES (NEW.*);
          ELSIF ( NEW.date >= DATE '2011-011-01' AND NEW.date < DATE '2011-12-01' ) THEN
              INSERT INTO daily_#{@column}_views_2011_11 VALUES (NEW.*);
          ELSIF ( NEW.date >= DATE '2011-12-01' AND NEW.date < DATE '2012-01-01' ) THEN
              INSERT INTO daily_#{@column}_views_2011_11 VALUES (NEW.*);
          ELSE
              RAISE EXCEPTION 'Date out of range. Fix date_#{@column}_trigger() function!';
          END IF;
          RETURN NULL;
      END;
      $$
      LANGUAGE plpgsql;
      
      CREATE TRIGGER insert_#{@column}_trigger
          BEFORE INSERT ON daily_#{@column}_views_master
          FOR EACH ROW EXECUTE PROCEDURE date_#{@column}_trigger();
    COMMAND
    
    @conn.exec(cmd)
  end
    
  def create_master_table
    cmd = <<-COMMANDS
      CREATE TABLE #{master_table}
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
    
    puts "Creating master partition table #{master_table}"
    @conn.exec(cmd)
  end
  
  def create_partition_table(partition)
    start_date = "2011-#{partition}-01"
    end_date = start_date.to_date.next_month.to_s
    
    cmd = <<-COMMANDS
      CREATE TABLE daily_#{@column}_views_2011_#{partition} (
          CHECK ( date >= DATE '#{start_date}' AND date < DATE '#{end_date}' )
      ) INHERITS (#{master_table});
    COMMANDS
    @conn.exec(cmd)
  end
  
  def index_on_date_and_article_id(month)
    cmd = <<-COMMANDS
      CREATE INDEX index_daily_#{@column}_views_2011_#{month}_on_date_n_article_id
        ON daily_#{@column}_views_2011_#{month}
        USING btree
        (date DESC, article_id);
    COMMANDS
    @conn.exec(cmd)
  end
    
  def index_on_date_and_writer_id(month)
    cmd = <<-COMMANDS
      CREATE INDEX index_daily_#{@column}_views_2011_#{month}_on_date_n_writer_id
        ON daily_#{@column}_views_2011_#{month}
        USING btree
        (date DESC, writer_id);
    COMMANDS
    @conn.exec(cmd)
  end

  def index_on_column(month)
    cmd = <<-COMMANDS
      CREATE INDEX index_daily_#{@column}_views_2011_#{month}_on_keyphrase
        ON daily_#{@column}_views_2011_#{month}
        USING btree
        (#{@column});
    COMMANDS
    @conn.exec(cmd)
  end
  
  def drop_index_on_date_and_article_id(index)
    cmd = <<-COMMANDS
      DROP INDEX IF EXISTS index_daily_#{@column}_views_2011_#{index}_on_date_n_article_id;
    COMMANDS
    @conn.exec(cmd)
  end
  
  def drop_index_on_date_and_writer_id(index)
    cmd = <<-COMMANDS
      DROP INDEX IF EXISTS index_daily_#{@column}_views_2011_#{index}_on_date_n_writer_id;
    COMMANDS
    @conn.exec(cmd)
  end
  
  def drop_index_on_column(index)
    cmd = <<-COMMANDS
      DROP INDEX IF EXISTS index_daily_#{@column}_views_2011_#{index}_on_keyphrase;
    COMMANDS
    @conn.exec(cmd)
  end
  
  def drop_tables
    cmd = "Drop TABLE IF EXISTS #{master_table} CASCADE;"
    @conn.exec(cmd)
  end
end