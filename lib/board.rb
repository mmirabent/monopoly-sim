require 'player'
require 'space'
require 'logging'

include Logging

class Board
  attr_reader :spaces
  
  def initialize(space_names, player = Player.new)
    Logging::log.debug("initializing board")
    @player = player
    @spaces = Array.new
    
    space_names.each do |name|
      Logging::log.debug("Adding" + name)
      @spaces.push(Space.new(name))
    end
  end
  
  def move_player_relative(moves)
    Logging::log.debug("Moving player %d spaces" % moves)
    @player.position += moves
    @spaces[@player.position % @spaces.length].hit
  end
  
  def move_player_absolute(space)
    Logging::log.debug("Moving player to space %d" % space)
    @player.position = space
    @spaces[space].hit
  end
  
  def player_relative_position
    @spaces[@player.position % @spaces.length]
  end
end
