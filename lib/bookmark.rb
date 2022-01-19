require 'pg'

class Bookmark
  attr_reader :id, :url, :title

  def initialize (id:, url:, title:)
    @id = id
    @title = title
    @url = url
  end

  def self.view_all
    if ENV['ENVIRONMENT'] == 'test' 
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect( dbname: 'bookmark_manager')
    end

    result = connection.exec('SELECT * FROM bookmarks')
    # result.map { |bookmark| bookmark['url'] }
    result.map do |bookmark| 
      Bookmark.new(id: bookmark["id"], title: bookmark["title"], url: bookmark["url"])
    end
  end

  def self.create(url, title)
    if ENV['ENVIRONMENT'] == 'test' 
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect( dbname: 'bookmark_manager')
    end

    # results = connection.exec("INSERT INTO bookmarks (url, title) VALUES ('#{url}', '#{title}') RETURNING id, url, title;")
    # Bookmark.new(id:results[0]["id"], url:results[0]["url"], title:results[0]["title"])

    results = connection.exec_params(
      # The first argument is our SQL query template
      # The second argument is the 'params' referred to in exec_params
      # $1 refers to the first item in the params array
      # $2 refers to the second item in the params array
    "INSERT INTO bookmarks (url, title) VALUES ($1, $2) RETURNING id, url, title;", [url, title])
    Bookmark.new(id:results[0]["id"], url:results[0]["url"], title:results[0]["title"])
  end

end