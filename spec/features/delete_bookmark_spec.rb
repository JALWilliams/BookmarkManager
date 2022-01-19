feature 'delete an existing bookmark' do
  scenario '- user can click button to delete bookmark' do
    visit ('/bookmarks')
    click_button('Delete link')
    visit ('/delete_bookmark')
    expect(page).to have_content ('Delete bookmark')
    # save_and_open_page
  end

  scenario '- user can specify title and url of bookmark to delete' do
    visit ('/bookmarks')
    click_button('Delete link')
    fill_in :title_to_delete, with: 'Destroy all Software'
    fill_in :url_to_delete, with: 'http://www.destroyallsoftware.com'
    click_button ('Submit')
  end

  scenario '- bookmark page updated to exclude bookmark' do
    visit ('/bookmarks')
    click_button('Delete link')
    fill_in :title_to_delete, with: 'Destroy all Software'
    fill_in :url_to_delete, with: 'http://www.destroyallsoftware.com'
    click_button ('Submit')
    visit ('/bookmarks')
    expect(page).to have_content ('Makers Academy')
    expect(page).to have_content ('Google')
  end

end