feature 'update existing bookmark' do 
  before do 
    visit ('/bookmarks')
    click_button 'Update bookmark'
  end

  scenario '- can click button to modify existing bookmarks'do
    expect(page).to have_content('Update bookmark')
  end

  scenario '- can insert the new bookmark requirments' do
    fill_in :title_to_update, with:'Brave Snacks'
    fill_in :url_to_update, with:'https://bravefoods.co.uk/collections/powerful-pulses'
    click_button 'Submit'
    expect(page).to have_link 'Brave Snacks', href: 'https://bravefoods.co.uk/collections/powerful-pulses'
  end

end