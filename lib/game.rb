require 'dice_roller'
require 'player'
require 'board'
require 'card_deck'

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

  GO                = 0
  ILLINOIS          = 24
  ST_CHARLES        = 11
  JAIL              = 10
  GOTO_JAIL         = 30
  READING_RAILROAD  = 5
  RAILROADS         = [5,15,25,35]
  UTILS             = [12,28]
  CHANCE            = [7,22,37]
  COMMUNITY_CHEST   = [2,17,33]
  
  
  COMM_CHEST_CARDS = [
    "Advance to Go (Collect $200)",
    "Bank error in your favor – Collect $200",
    "Doctor's fees – Pay $50",
    "From sale of stock you get $50",
    "Get Out of Jail Free – This card may be kept until needed or sold",
    "Go to Jail – Go directly to jail – Do not pass Go – Do not collect $200",
    "Grand Opera Night – Collect $50 from every player for opening night seats",
    "Holiday Fund matures - Receive $100",
    "Income tax refund – Collect $20",
    "It is your birthday - Collect $10 from each player",
    "Life insurance matures – Collect $100",
    "Pay hospital fees of $100",
    "Pay school fees of $150",
    "Receive $25 consultancy fee",
    "You are assessed for street repairs – $40 per house – $115 per hotel",
    "You have won second prize in a beauty contest – Collect $10",
    "You inherit $100"
  ]
  
  COMM_GO = COMM_CHEST_CARDS[0]
  COMM_JAIL = COMM_CHEST_CARDS[5]
  
  
  CHANCE_CARDS = [
    "Advance to Go (Collect $200)",
    "Advance to Illinois Ave. - If you pass Go, collect $200",
    "Advance to St. Charles Place – If you pass Go, collect $200",
    "Advance token to nearest Utility. If unowned, you may buy it from the Bank. If owned, throw dice and pay owner a total ten times the amount thrown.",
    "Advance token to the nearest Railroad and pay owner twice the rental to which he/she is otherwise entitled. If Railroad is unowned, you may buy it from the Bank. (There are two of these.)",
    "Bank pays you dividend of $50",
    "Get out of Jail Free – This card may be kept until needed, or traded/sold",
    "Go back 3 spaces",
    "Go to Jail – Go directly to Jail – Do not pass Go, do not collect $200",
    "Make general repairs on all your property – For each house pay $25 – For each hotel $100",
    "Pay poor tax of $15",
    "Take a trip to Reading Railroad – If you pass Go, collect $200",
    "Take a walk on the Boardwalk – Advance token to Boardwalk",
    "You have been elected Chairman of the Board – Pay each player $50",
    "Your building loan matures – Collect $150",
    "You have won a crossword competition - Collect $100"
  ]
  
  CHANCE_GO                 = CHANCE_CARDS[0];
  CHANCE_ILLINOIS           = CHANCE_CARDS[1];
  CHANCE_ST_CHARLES         = CHANCE_CARDS[2];
  CHANCE_UTIL               = CHANCE_CARDS[3];
  CHANCE_RR                 = CHANCE_CARDS[4];
  CHANCE_BACK_THREE         = CHANCE_CARDS[7];
  CHANCE_JAIL               = CHANCE_CARDS[8];
  CHANCE_READING_RAILROAD   = CHANCE_CARDS[11];
  CHANCE_BOARDWALK          = CHANCE_CARDS[13];
  

  def initialize
    Logging::log.debug("initializing game")
    @dice   = DiceRoller.new
    @player = Player.new
    @board  = Board.new(SPACE_NAMES, @player)
    @comm   = CardDeck.new(COMM_CHEST_CARDS)
    @chance = CardDeck.new(CHANCE_CARDS)
    @comm.shuffle
    @chance.shuffle
  end
  
  def jail_player
    Logging::log.debug("Jailing player")
    @board.move_player_absolute(JAIL)
  end
  
  def read_comm_chest_card
    Logging::log.debug("Reading Community Chest card: " + card = @comm.next_card)
    case card
    when COMM_GO
      Logger::log.debug("Moving player to Go")
      @board.move_player_absolute(GO)
    when COMM_JAIL
      jail_player
    end
  end
  
  def read_chance_card
    Logging::log.debug("Reading Chance card: " + card = @chance.next_card)
    case card
    when CHANCE_GO
      Logger::log.debug("Moving player to go")
      @board.move_player_absolute(GO)
    when CHANCE_ILLINOIS
      Logger::log.debug("Moving Player to Illinois Ave")
      @board.move_player_absolute(ILLINOIS)
    when CHANCE_ST_CHARLES
      Logger::log.debug("Moving player to St. Charles Place")
      @board.move_player_absolute(ST_CHARLES)
    when CHANCE_UTIL
      Logger::log.debug("Moving to nearest utility")
      pos = @board.player_relative_position
      while !UTILS.include?(pos)
        pos += 1
      end
      @board.move_player_absolute(pos)
    when CHANCE_RR
      Logger::log.debug("Moving to nearest railroad")
      pos = @board.player_relative_position
      while !RR.include?(pos)
        pos += 1
      end
      @board.move_player_absolute(pos)
    when CHANCE_BACK_THREE
      Logger::log.debug("Moving back three spaces")
      @board.move_player_relative(-3)
      if COMMUNITY_CHEST.include?(@board.player_relative_position)
        read_comm_chest_card
      end
    when CHANCE_JAIL
      jail_player
    when CHANCE_READING_RAILROAD
      Logger::log.debug("Moving player to The Reading Railroad")
      @board.move_player_absolute(READING_RAILROAD)
    when CHANCE_BOARDWALK
      Logger::log.debug("Moving player to Boardwalk")
      @board.move_player_absolute(BOARDWALK)
    end
  end
    
  
  def turn
    die1 = @dice.d6
    die2 = @dice.d6
    Logging::log.debug("The die rolls were %d, %d" % [ die1, die2 ])
    
    
    # If doubles, log it and increment the count of doubles. If not, clear the double counter
    if die1 == die2
      @player.increment_double_count
      Logging::log.debug("Doubles!")
    else
      @player.double_count = 0
    end
    
    # If we just roller our third double, to the slammer with you
    if @player.double_count > 2
      @player.double_count = 0
      Logging::log.debug("Rolled three doubles in a row")
      jail_player
    else
      @board.move_player_relative(die1 + die2)
    end
    
    # If we have landed on any special spaces, go to jail or draw an action
    if @board.player_relative_position == GOTO_JAIL
      Logging::log.debug("Landed on Go To Jail")
      jail_player
    elsif CHANCE.include?(@board.player_relative_position)
      read_chance_card
    elsif COMMUNITY_CHEST.include?(@board.player_relative_position)
      read_comm_chest_card
    end
  end
end
