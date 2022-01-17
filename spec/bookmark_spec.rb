require 'bookmark'

describe Bookmark do

  # Class itself as { described_class } and not { described_class.new}
  subject(:bookmark_manager) { described_class }

  it 'can display all the bookmarks' do
    expect(bookmark_manager.view_all).to include("www.net-a-porter.com", "www.google.com")
  end

end