feature 'viewing bookmarks' do
  scenario 'it can list all the bookmarks' do
    visit ('/bookmarks')
    expect(page).to have_content("Bookmarks")
    expect(page).to have_content("www.google.com")
    expect(page).to have_content("www.net-a-porter.com")
  end

end