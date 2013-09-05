require './dice_roller'
require './player'
require './board'

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
    puts "initializing game"
    @dice   = DiceRoller.new
    @player = Player.new
    @board  = Board.new(SPACE_NAMES, @player)
  end
  
  # def move_player(moves)
  #   puts "Moving player %d spaces" % moves
  #   @player.position += moves
  #   @spaces[@player.position % @spaces.length].hit
  # end
  # 
  # def jail_player
  #   puts "Jailing player"
  #   @player.position = JAIL
  #   @spaces[JAIL].hit
  # end
  
  def turn
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
      @board.move_player_relative(die1 + die2)
    end
    
    # relative_pos = @player.position % @spaces.length
    
    if @board.player_relative_position == GOTO_JAIL
      jail_player
    elsif CHANCE.include?(@board.player_relative_position)
      puts "reading chance card"
    elsif COMMUNITY_CHEST.include?(@board.player_relative_position)
      puts "Reading community chest card"
    end
  end
end
