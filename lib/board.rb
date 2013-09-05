require './player'
require './space'

class Board
  attr_reader :spaces
  
  def initialize(space_names, player = Player.new)
    puts "initializing board"
    @player = player
    @spaces = Array.new
    
    space_names.each do |name|
      puts "Adding" + name
      @spaces.push(Space.new(name))
    end
  end
  
  def move_player_relative(moves)
    puts "Moving player %d spaces" % moves
    @player.position += moves
    @spaces[@player.position % @spaces.length].hit
  end
  
  def move_player_absolute(space)
    puts "Moving player to space %d" % space
    @player.position = space
    @spaces[space].hit
  end
  
  def player_relative_position
    @spaces[@player.position % @spaces.length]
  end
end
