module WriterPartition
  # column can be
  # keyphrase, domain, or page
  def trigger(column)
    <<-COMMAND
      CREATE OR REPLACE FUNCTION writers_#{column}_trigger() 
      RETURNS TRIGGER AS $$ 
      DECLARE
        ins_sql TEXT; 
      BEGIN
        ins_sql := 'INSERT INTO daily_#{column}_views_' || (NEW.writer_id % #{PARTITION_SIZE}) ||
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
  
  def create_partition_table(column, partition, master_table)
    "CREATE TABLE daily_#{column}_views_#{partition}( ) INHERITS (#{master_table});"
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

  def index_on_keyphrase(index, column)
    <<-COMMANDS
      CREATE INDEX index_daily_#{column}_views_#{index}_on_writer_id_n_date
        ON daily_#{column}_views_#{index}
        USING btree
        (keyphrase);
    COMMANDS
  end
  
  def drop_index_on_article_id_and_date(index, column)
    <<-COMMANDS
      DROP INDEX IF EXISTS index_daily_#{column}_views_#{index}_on_article_id_n_date;
    COMMANDS
  end
  
  def drop_index_on_writer_id_and_date(index, column)
    <<-COMMANDS
      DROP INDEX IF EXISTS index_daily_#{column}_views_#{index}_on_writer_id_n_date;
    COMMANDS
  end
  
  def drop_index_on_keyphrase(index, column)
    <<-COMMANDS
      DROP INDEX IF EXISTS index_daily_#{column}_views_#{index}_on_keyphrase;
    COMMANDS
  end
end