require 'sinatra/base'
require 'sinatra/reloader'
require_relative './lib/bookmark.rb'
require './database_connection_setup'


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
    session[:new_bookmark_url] = params[:URL]
    session[:new_bookmark_title] = params[:title]
    # @new_bookmark = session[:new_bookmark]
    Bookmark.create(session[:new_bookmark_url], session[:new_bookmark_title])
    # erb :'bookmarks/test' 
    redirect ('/bookmarks')
  end

  get '/delete_bookmark' do 
    erb :'bookmarks/delete_bookmark' 
  end

  post '/delete_bookmark' do 
    session[:delete_bookmark_url] = params[:title_to_delete]
    session[:delete_bookmark_title] = params[:url_to_delete]
    Bookmark.delete(params[:url_to_delete], params[:title_to_delete])
    redirect ('/bookmarks')
  end

  get '/update_bookmark' do
    erb :'bookmarks/update_bookmark'
  end

  post '/update_bookmark' do
    session[:update_bookmark_url] = params[:title_to_update]
    session[:update_bookmark_title] = params[:url_to_update]
    Bookmark.update(params[:url_to_update], params[:title_to_update])
    redirect ('/bookmarks')
  end

  run! if app_file == $0
end
