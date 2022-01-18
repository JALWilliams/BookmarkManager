require 'sinatra/base'
require 'sinatra/reloader'
require_relative './lib/bookmark.rb'

class BookmarkManager < Sinatra::Base
  enable :sessions

  configure :development do
    register Sinatra::Reloader
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.view_all
    erb :'bookmarks/index' 
  end

  get '/add_bookmark' do 
    erb :'bookmarks/add_bookmark' 
  end

  post '/add_bookmark' do  
    session[:new_bookmark] = params[:URL]
    # @new_bookmark = session[:new_bookmark]
    Bookmark.create(session[:new_bookmark])
    # erb :'bookmarks/test' 
    redirect ('/bookmarks')
  end

  run! if app_file == $0
end
