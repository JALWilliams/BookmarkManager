feature 'bookmarks homepage' do
  scenario 'it can list all the bookmarks' do
    visit ('/')
    expect(page).to have_content("Bookmarks")
  end

end