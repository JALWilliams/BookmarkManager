require 'sinatra/base'
require 'sinatra/reloader'
require_relative './lib/bookmark.rb'

class BookmarkManager < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.view_all
    erb(:'bookmarks/index')
  end

  run! if app_file == $0
end
