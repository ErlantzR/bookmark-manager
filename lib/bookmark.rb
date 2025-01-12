require 'pg'


class Bookmark

  attr_reader :id, :title, :url

  def initialize(id:, title:, url:)
    @id  = id
    @title = title
    @url = url
  end

  def self.all
    result = DatabaseConnection.query("SELECT * FROM bookmarks;")
    result.map do |bookmark|
      Bookmark.new(id: bookmark['id'], title: bookmark['title'], url: bookmark['url'])
    end
  end

  def self.create(url:, title:)
    result = DatabaseConnection.query( "INSERT INTO bookmarks (url, title) VALUES( $1 ,$2) RETURNING id, url, title;", ["#{url}", "#{title}"])
    Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
  end

  def self.delete(id:)
    DatabaseConnection.query("DELETE FROM bookmarks WHERE id = $1;", [id])
  end

  def self.update(id:, url:, title:)
    DatabaseConnection.query("UPDATE bookmarks SET url = $1, title = $2 WHERE id = $3;", [url,title,id ])
  end
end
