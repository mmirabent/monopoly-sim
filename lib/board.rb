require './dice_roller'
require './player'
require './space'

class Board
  # @spaces = 40
  SPACE_NAMES = [
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
  JAIL = 10
  GOTO_JAIL = 30
  CHANCE = [7,22,37]
  COMMUNITY_CHEST = [2,17,33]

  def initialize
    puts "initializing"
    @dice   = DiceRoller.new
    @player = Player.new
    @spaces = Array.new
    
    SPACE_NAMES.each do |name|
      puts "Adding" + name
      @spaces.push(Space.new(name))
    end
  end
  
  def move_player(moves)
    puts "Moving player %d spaces" % moves
    @player.position += moves
    @spaces[@player.position % @spaces.length].hit
  end
  
  def jail_player
    puts "Jailing player"
    @player.position = JAIL
    @spaces[JAIL].hit
  end
  
  def turn
    puts "Rolling dice"
    die1 = @dice.d6
    die2 = @dice.d6
    puts "The die rolls were %d, %d" % [ die1, die2 ]
    
    
    if die1 == die2
      @player.increment_double_count
      puts "Doubles!"
    end
    
    if @player.double_count > 2
      @player.double_count = 0
      jail_player
    else
      move_player(die1 + die2)
    end
    
    relative_pos = @player.position % @spaces.length
    
    if relative_pos == GOTO_JAIL
      jail_player
    elsif CHANCE.include?(relative_pos)
      puts "reading chance card"
    elsif COMMUNITY_CHEST.include?(relative_pos)
      puts "Reading community chest card"
    end
  end
  
  def spaces
    @spaces
  end
end
