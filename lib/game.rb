require 'dice_roller'
require 'player'
require 'board'

class Game
  attr_reader :board
  
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
    Logging::log.debug("initializing game")
    @dice   = DiceRoller.new
    @player = Player.new
    @board  = Board.new(SPACE_NAMES, @player)
  end
  
  def jail_player
    Logging::log.debug("Jailing player")
    @board.move_player_absolute(JAIL)
  end
  
  def turn
    die1 = @dice.d6
    die2 = @dice.d6
    Logging::log.debug("The die rolls were %d, %d" % [ die1, die2 ])
    
    
    if die1 == die2
      @player.increment_double_count
      Logging::log.debug("Doubles!")
      
    else
      @player.double_count = 0
      
    end
    
    if @player.double_count > 2
      @player.double_count = 0
      jail_player
      
    else
      @board.move_player_relative(die1 + die2)
      
    end
    
    # relative_pos = @player.position % @spaces.length
    
    if @board.player_relative_position == GOTO_JAIL
      Logging::log.debug("Landed on Go To Jail")
      jail_player
      
    elsif CHANCE.include?(@board.player_relative_position)
      Logging::log.debug("reading chance card")
      
    elsif COMMUNITY_CHEST.include?(@board.player_relative_position)
      Logging::log.debug("Reading community chest card")
      
    end
  end
end
