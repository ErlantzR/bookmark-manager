require 'database_connection'

describe DatabaseConnection do 
  let(:subject) { described_class } 
  
  describe '#.setup' do 
    it 'responds to the the method .setup' do 
      expect(subject).to respond_to(:setup).with(1).arguments
    end 

    it 'connects to the correct database' do 
      dbname = 'bookmark_manager_test'
      expect(PG).to receive(:connect).with(dbname: dbname)
      subject.setup(dbname)
    end 
  end 

  describe '.query' do 
    it 'executes an SQL query string on the correct database' do 
      dbname = 'bookmark_manager_test'
      subject.setup(dbname)
      expect(subject.connection).to receive(:exec_params).with('SELECT * FROM bookmarks;', [ ])
      subject.query('SELECT * FROM bookmarks;', [ ])
    end 
  end
end

# DatabaseConnection.query is a class method. 
# / It takes two parameters: an SQL query string and an optional array. It should use the class instance variable from setup to execute that SQL query string on the correct database, via pg.