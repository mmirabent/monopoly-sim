class CardDeck
  attr_reader :cards
  
  def initialize(card_names)
    @cards = Array.new
    card_names.each do |name|
      @cards.push(name.to_s)
    end
  end
  
  def shuffle
    @cards.shuffle!
  end
  
  def next_card
    current_card = @cards.shift
    @cards.push(current_card)
    current_card
  end
end