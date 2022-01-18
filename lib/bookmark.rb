require 'pg'

class Bookmark

  def self.view_all
    if ENV['ENVIRONMENT'] == 'test' 
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect( dbname: 'bookmark_manager')
    end

    result = connection.exec('SELECT * FROM bookmarks')
    result.map { |bookmark| bookmark['url'] }
    # result.map { |bookmark| bookmark['title'] }

  end

  def self.create(url, title)
    if ENV['ENVIRONMENT'] == 'test' 
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect( dbname: 'bookmark_manager')
    end

    connection.exec("INSERT INTO bookmarks (url, title) VALUES ('#{url}', '#{title}') RETURNING id, url, title;")
  end

end