class Player
  def initialize
    @position = 0
    @double_count = 0
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
  
  def double_count=(new_double_count)
    @double_count = new_double_count
  end
  
  def increment_double_count
    @double_count += 1
  end
  
  def double_count
    @double_count
  end
end