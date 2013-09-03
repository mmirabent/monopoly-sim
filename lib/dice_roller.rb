class DiceRoller
  def initialize(seed = nil)
    if seed
      @prng = Random.new(seed)
    else
      @prng = Random.new
    end
  end
  
  def d6
    @prng.rand(1..6)
  end
end