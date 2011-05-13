sql = ActiveRecord::Base.connection();
sql.execute("SET constraint_exclusion = on;") 