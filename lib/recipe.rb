class Recipe
  attr_reader :name, :description, :rating, :duration, :readed

  def initialize(hash)
    @name = hash[:name]
    @description = hash[:description]
    @rating = hash[:rating]
    @duration = hash[:duration]
    @readed = hash[:readed]
  end

  def mark_as_read!
    @readed = true
  end
end
