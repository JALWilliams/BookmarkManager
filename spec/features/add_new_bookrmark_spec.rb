feature 'Add new bookmark to Bookmark Manager' do 
  scenario '- I can click on a button that redirects me to /add_bookmark form' do 
    visit ('/bookmarks')
    click_button 'Add link'
    visit ('/add_bookmark')
    expect(page).to have_content ("Add new bookmark")
  end

  scenario '- I can add a new link to create a bookmark' do 
    visit ('/bookmarks')
    click_button 'Add link'
    fill_in :URL ,with: 'https://www.net-a-porter.com'
    click_button 'Submit'
    expect(page).to have_content ('https://www.net-a-porter.com')
  end

end