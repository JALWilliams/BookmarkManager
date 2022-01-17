require 'bookmark'

describe Bookmark do

  # Class itself as { described_class } and not { described_class.new}
  subject(:bookmark_manager) { described_class }

  it 'can display all the bookmarks' do
    connection = PG.connect(dbname: 'bookmark_manager_test')

    # Add the test data
    connection.exec("INSERT INTO bookmarks (url) VALUES ('http://www.makersacademy.com');")
    connection.exec("INSERT INTO bookmarks (url) VALUES('http://www.destroyallsoftware.com');")
    connection.exec("INSERT INTO bookmarks (url) VALUES('http://www.google.com');")

    expect(bookmark_manager.view_all).to include("http://www.makersacademy.com", "http://www.google.com", "http://www.destroyallsoftware.com")
  end

end