require 'pg'

feature 'viewing bookmarks' do
  scenario 'A user can see bookmarks' do
    connection = PG.connect(dbname: 'bookmark_manager_test')

    # Add the test data
    connection.exec("INSERT INTO bookmarks VALUES(4, 'http://www.makersacademy.com', 'Makers Academy');")
    connection.exec("INSERT INTO bookmarks VALUES(5, 'http://www.destroyallsoftware.com', 'Destroy all Software');")
    connection.exec("INSERT INTO bookmarks VALUES(6, 'http://www.google.com', 'Google');")


    visit ('/bookmarks')
    expect(page).to have_content("Bookmarks")
    expect(page).to have_link 'Makers Academy', href: 'http://www.makersacademy.com'
    expect(page).to have_link 'Google', href: 'http://www.google.com'
    expect(page).to have_link 'Destroy all Software', href: 'http://www.destroyallsoftware.com'
  
  end

end