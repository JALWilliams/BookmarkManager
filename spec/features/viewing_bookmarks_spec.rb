feature 'viewing bookmarks' do
  scenario 'it can list all the bookmarks' do
    visit ('/bookmarks')
    expect(page).to have_content("Bookmarks")
    expect(page).to have_content("http://www.makersacademy.com")
    expect(page).to have_content("http://www.google.com")
    expect(page).to have_content("http://www.destroyallsoftware.com")
  end

end