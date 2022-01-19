require 'pg'

feature 'viewing bookmarks' do
  scenario 'A user can see bookmarks' do
    connection = PG.connect(dbname: 'bookmark_manager_test')

    # Add the test data
    connection.exec("INSERT INTO bookmarks VALUES(1, 'http://www.makersacademy.com', 'Makers Academy');")
    connection.exec("INSERT INTO bookmarks VALUES(2, 'http://www.destroyallsoftware.com', 'Destroy all Software');")
    connection.exec("INSERT INTO bookmarks VALUES(3, 'http://www.google.com', 'Google');")


    visit ('/bookmarks')
    expect(page).to have_content("Bookmarks")
    expect(page).to have_content("Makers Academy")
    expect(page).to have_content("Google")
    expect(page).to have_content("Destroy all Software")
    # expect(page).to have_content("http://www.makersacademy.com")
    # expect(page).to have_content("http://www.google.com")
    # expect(page).to have_content("http://www.destroyallsoftware.com")
  end

end