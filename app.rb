require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/bookmark'
require_relative 'lib/database_connection'

if ENV['ENVIRONMENT'] == 'test'
  DatabaseConnection.setup('bookmark_manager_test')
else
  DatabaseConnection.setup('bookmark_manager')
end 

class BookmarkManager < Sinatra::Base
  set :method_override, true # make a note about this and corrosponding in the erb file
  configure :development do
    register Sinatra::Reloader
  end

  enable :sessions

  get '/bookmarks/create' do
    erb :'bookmarks/create'
  end

  delete '/bookmarks/:id' do
    Bookmark.delete(id: params[:id])
    redirect '/bookmarks'
  end

  patch '/bookmarks/:id' do
    session[:id] = params[:id]
    erb :'bookmarks/update'
  end

  post '/bookmarks/update' do
    Bookmark.update(id: session[:id], url: params[:url], title: params[:title])
    redirect '/bookmarks'
  end

  post '/bookmarks' do
    Bookmark.create(url: params[:bookmark], title: params[:title])
    redirect '/bookmarks'
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.all
    erb :'bookmarks/index'
  end

  run! if app_file == $0
end
