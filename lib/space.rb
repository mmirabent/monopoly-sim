class Space
  attr_reader :name, :hit_count
  def initialize(name)
    @name = name
    @hit_count = 0
  end
  
  def hit
    @hit_count += 1
  end
end
