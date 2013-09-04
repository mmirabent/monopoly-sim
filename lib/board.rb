require './dice_roller'
require './player'
require './space'

class Board
  # @spaces = 40
  @@space_names = [
    "Go",
    "Mediteranean Avenue",
    "Community Chest",
    "Baltic Avenue",
    "Income Tax",
    "Reading Railroad",
    "Oriental Avenue",
    "Chance",
    "Vermont Avenue",
    "Connecticut Avenue",
    "In Jail",
    "St. Charles Place",
    "Electric Company",
    "States Avenue",
    "Virginia Avenue",
    "Pennsylvania Railroad",
    "St. James Place",
    "Community Chest",
    "Tennessee Avenue",
    "New York Avenue",
    "Free Parking",
    "Kentucky Avenue",
    "Chance",
    "Indiana Avenue",
    "Illinois Avenue",
    "B&O Railroad",
    "Atlantic Avenue",
    "Ventnor Avenue",
    "Water Works",
    "Marvin Gardens",
    "Go To Jail",
    "Pacific Avenue",
    "North Carolina Avenue",
    "Community Chest",
    "Pennsylvania Avenue",
    "Short Line",
    "Chance",
    "Park Place",
    "Luxury Tax",
    "Boardwalk"
  ]
  @@JAIL = 10

  def initialize
    @dice   = DiceRoller.new
    @player = Player.new
    @spaces = Array.new
    
    @@space_names.each do |name|
      @spaces.push(space.new(name))
    end
  end
  
  def move_player(moves)
    @player.position += moves
    @spaces[@player.position].hit
  end
  
  def jail_player
    @player.position = @@JAIL
    @spaces[@@JAIL].hit
  end
  
  def turn
    die1 = @dice.d6
    die2 = @dice.d6
    if die1 == die2
      @player.increment_double_count
    end
    
    if @player.double_count > 2
      @player.double_count = 0
      jail_player
    else
      move_player(die1 + die2)
    end
  end
end
