require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry-byebug'
require 'better_errors'
require_relative 'lib/cookbook'
require_relative 'lib/recipe'
set :bind, '0.0.0.0'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path(__dir__, __FILE__)
end

get '/' do
  cookbook = Cookbook.new('lib/recipes.csv')
  @recipes = cookbook.all
  erb :index
end

get '/new' do
  erb :new
end

post '/recipes' do
  cookbook = Cookbook.new('lib/recipes.csv')
  new_recipe = Recipe.new(params)
  cookbook.add_recipe(new_recipe)
  redirect '/'
end

get '/destroy/:i' do
  cookbook = Cookbook.new('lib/recipes.csv')
  cookbook.remove_recipe(params[:i].to_i)
  redirect '/'
end
