require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require './models.rb'

enable :sessions

get '/' do
  @users = User.all
  # session[:url_now] = request.path_info
  if session[:user]
    @myself = User.find(session[:user])
    erb :top
  else
    erb :index
  end
end

get '/user/:id' do
  @user = User.find(params[:id])
  if session[:user]
    @myself = User.find(session[:user])
  end
  @articles = @user.articles.order(created_at: 'desc')
  erb :articles
end

get '/signup' do
  erb :signup
end

get '/signin' do
  erb :signin
end

post '/signup' do
  @user = User.create!({
    user_name: params[:user_name],
    user_email: params[:user_email],
    password: params[:password],
    password_confirmation: params[:password_confirmation]
  })
  if @user.persisted?
    session[:user] = @user.id
  end
  redirect '/'
end

post '/signin' do
  user = User.find_by(user_email: params[:user_email])
  if user && user.authenticate(params[:password])
    session[:user] = user.id
    redirect '/'
  end
end

get '/edit' do
  @myself = User.find(session[:user])
  erb :edit
end
post '/edit' do
  @user = User.find(session[:user])
  @user.articles.create({
    title: params[:title],
    body: params[:body],
  })
  redirect '/'
end

get '/:user/items/:id' do
  if session[:user]
    @myself = User.find(session[:user])
  end
  @article = Article.find(params[:id])
  erb :item
end

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
end

get '/signout' do
  session.clear
  redirect '/'
end