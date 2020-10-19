require 'nokogiri'
require 'open-uri'
require_relative 'view'
require_relative 'recipe'
require_relative 'scrapservice'

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    @view.display(@cookbook.all)
  end

  def create
    name = @view.create_name
    description = @view.create_description
    rating = @view.create_rating
    duration = @view.create_duration
    recipe = Recipe.new({ name: name, description: description, rating: rating, duration: duration, readed: false })
    @cookbook.add_recipe(recipe)
  end

  def destroy
    @view.display(@cookbook.all)
    index = @view.destroy_index
    @cookbook.remove_recipe(index)
  end

  def import
    ingredient = @view.create_import
    parse = ScrapService.new(ingredient)
    array_of_recipes = parse.call
    @view.display_import(array_of_recipes)
    title_index = @view.which_import
    recipe = Recipe.new(array_of_recipes[title_index])
    @cookbook.add_recipe(recipe)
  end

  def mark
    @view.display(@cookbook.all)
    index = @view.which_mark
    @cookbook.mark_as_read(index)
  end
end
