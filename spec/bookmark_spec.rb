require 'bookmark'

describe Bookmark do

  # Class itself as { described_class } and not { described_class.new}
  subject(:bookmark_manager) { described_class }

  describe 'view_all' do
    it 'can display all the bookmarks' do
      connection = PG.connect(dbname: 'bookmark_manager_test')

      # Add the test data
      connection.exec("INSERT INTO bookmarks (url) VALUES ('http://www.makersacademy.com');")
      connection.exec("INSERT INTO bookmarks (url) VALUES('http://www.destroyallsoftware.com');")
      connection.exec("INSERT INTO bookmarks (url) VALUES('http://www.google.com');")

      expect(bookmark_manager.view_all).to include("http://www.makersacademy.com", "http://www.google.com", "http://www.destroyallsoftware.com")
    end

  end

  describe 'create' do
    it 'can create a new enty in the database w/new bookmark' do
       new_bookmark = bookmark_manager.create('https://net-a-porter',"Net-A-Porter")
      #  p  new_bookmark => array of hashes w/ individual rows 
      #  p new_bookmark[0] => last has added! or new_bookmark.last[]
      expect(new_bookmark[0]['title']).to eq ("Net-A-Porter")
      expect(new_bookmark[0]['url']).to eq ("https://net-a-porter")
    end
  end
  

end