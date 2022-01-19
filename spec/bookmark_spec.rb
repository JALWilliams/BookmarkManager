require 'bookmark'

describe Bookmark do

  # Class itself as { described_class } and not { described_class.new}
  subject(:bookmark_manager) { described_class }

  describe 'view_all' do
    it 'can display all the bookmarks' do
      connection = PG.connect(dbname: 'bookmark_manager_test')

      # Add the test data
      connection.exec("INSERT INTO bookmarks VALUES(1, 'http://www.makersacademy.com', 'Makers Academy');")
      connection.exec("INSERT INTO bookmarks VALUES(2, 'http://www.destroyallsoftware.com', 'Destroy all Software');")
      connection.exec("INSERT INTO bookmarks VALUES(3, 'http://www.google.com', 'Google');")

      # expect(bookmark_manager.view_all).to include("http://www.makersacademy.com", "http://www.google.com", "http://www.destroyallsoftware.com")
      # Below returns an array of instances (objects)
      bookmarks = bookmark_manager.view_all
      expect(bookmarks[0].title).to include ('Makers Academy')
      expect(bookmarks[0].url).to include ('http://www.makersacademy.com')
    end

  end

  describe 'create' do
    it 'can create a new enty in the database w/new bookmark' do
       new_bookmark = bookmark_manager.create('https://net-a-porter',"Net-A-Porter")
      #  p  new_bookmark => array of hashes w/ individual rows 
      #  p new_bookmark[0] => last has added! or new_bookmark.last[]
      # expect(new_bookmark[0]['title']).to eq ("Net-A-Porter")
      # expect(new_bookmark[0]['url']).to eq ("https://net-a-porter")
      expect(new_bookmark.title).to eq ("Net-A-Porter")
      expect(new_bookmark.url).to eq ("https://net-a-porter")
    end
  end
  

end