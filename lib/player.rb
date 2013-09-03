class Player
  def initialize
    @position = 0
  end
  
  # Returns the absolute position in total number of moves made since the
  # simulation started. In order to get current position, the board would have
  # to take this number and do a modulus operation with the board size
  def position
    @position
  end
  
  def position=(new_position)
    @position = new_position
  end
end