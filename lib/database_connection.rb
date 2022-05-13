class DatabaseConnection

  def self.setup(dbname)
    @@connection = PG.connect(dbname: dbname)
  end

  def self.connection
    @@connection
  end 

  def self.query(query, array = [])
    @@connection.exec_params(query, array) 
  end 
end


