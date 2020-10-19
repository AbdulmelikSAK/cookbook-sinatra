class ScrapService # or ScrapeMarmitonService
  def initialize(ingredient)
    @ingredient = ingredient
  end

  def call
    url = "https://www.marmiton.org/recettes/recherche.aspx?type=all&aqt=#{@ingredient}"
    doc = Nokogiri::HTML(open(url), nil, 'utf-8')
    cards = doc.search('.recipe-card').take(5)
    create_array_of_hash(cards)
  end

  private

  def create_array_of_hash(cards)
    cards.map do |card|
      {
        name: card.search('.recipe-card__title').text.strip,
        description: card.search('.recipe-card__description').text.strip,
        rating: card.search('.recipe-card__rating__value').text.strip,
        duration: card.search('.recipe-card__duration').text.strip,
        readed: false
      }
    end
  end
end
