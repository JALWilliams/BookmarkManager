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

  def self.delete(url, title)

    if ENV['ENVIRONMENT'] == 'test' 
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect( dbname: 'bookmark_manager')
    end

    results = connection.exec_params("DELETE FROM bookmarks WHERE url = ($1) and title = ($2);", [url, title])
  end

  def self.update(url, title)
    if ENV['ENVIRONMENT'] == 'test' 
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect( dbname: 'bookmark_manager')
    end

    if self.exists?(url,title)
      connection.exec_params("UPDATE bookmarks SET url = $1, title = $2  WHERE url = $1 OR title = $2;", [url, title])
    else 
      self.create(url,title)
    end

  end

  private 

  def self.exists?(url,title)
    bookmarks = Bookmark.view_all 

    bookmark_titles = [ ]
    bookmark_urls = [ ]

    bookmarks.map do |bookmark|
        bookmark_titles.push(bookmark.title)
        bookmark_urls.push(bookmark.url)
    end

    bookmark_urls.include?(url) || bookmark_titles.include?(title) 
  end


end