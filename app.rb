require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry-byebug'
require 'better_errors'
require 'nokogiri'
require 'open-uri'
require 'sinatra/cookies'
require_relative 'lib/cookbook'
require_relative 'lib/recipe'
require_relative 'lib/scrapservice'
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

get '/markdone/:i' do
  cookbook = Cookbook.new('lib/recipes.csv')
  cookbook.mark_as_read(params[:i].to_i)
  redirect '/'
end

get '/import' do
  erb :import
end

post '/scraped' do
  scrap = ScrapService.new(params[:ingredient])
  $scraped = scrap.call
  @scraped = $scraped
  # cookies[:scraped] = scrap.call
  erb :scrap
end

get '/add_import/:index' do
  cookbook = Cookbook.new('lib/recipes.csv')
  recipe = Recipe.new($scraped[params[:index.to_s].to_i])
  cookbook.add_recipe(recipe)
  redirect '/'
end
