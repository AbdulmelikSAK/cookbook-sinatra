require 'csv'
require_relative 'recipe'

class Cookbook
  def initialize(csv_file_path)
    @recipes = []
    @csv_file_path = csv_file_path
    load_csv
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    update_csv
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    update_csv
  end

  def mark_as_read(index)
    @recipes[index].mark_as_read!
    update_csv
  end

  private

  def load_csv
    CSV.foreach(@csv_file_path) do |row|
      @recipes << Recipe.new({
                               name: row[0],
                               description: row[1],
                               rating: row[2],
                               duration: row[3],
                               readed: row[4] == 'true'
                             })
    end
  end

  def update_csv
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
    CSV.open(@csv_file_path, 'wb', csv_options) do |csv|
      @recipes.each do |saved|
        csv << [saved.name, saved.description, saved.rating, saved.duration, saved.readed]
      end
    end
  end
end
