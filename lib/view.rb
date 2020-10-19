class View
  def display(all_recipes)
    all_recipes.each_with_index do |recipe, index|
      done = recipe.readed ? "X" : " "
      puts "#{index + 1}. [#{done}] #{recipe.name} (#{recipe.rating}/5)"
    end
  end

  def display_import(array)
    array.each_with_index do |recipe, index|
      puts "#{index + 1}. #{recipe[:name]}"
    end
  end

  def create_name
    puts "Whats is the name of the recipe ?"
    print "> "
    gets.chomp
  end

  def create_description
    puts "What is the description of this recipe ?"
    print "> "
    gets.chomp
  end

  def create_rating
    puts "What is the rating of this recipe ?"
    print "> "
    gets.chomp
  end

  def create_duration
    puts "What is the duration of this recipe ?"
    print "> "
    gets.chomp
  end

  def destroy_index
    puts "Wich recipe do you want to destroy ?:"
    print "> "
    gets.chomp.to_i - 1
  end

  def create_import
    puts "What ingredient would you like a recipe for ?"
    print "> "
    gets.chomp
  end

  def which_import
    puts "Which recipe would you like to import ?"
    print "> "
    gets.chomp.to_i - 1
  end

  def which_mark
    puts "Which recipe would you like to mark as read ?"
    print "> "
    gets.chomp.to_i - 1
  end
end
