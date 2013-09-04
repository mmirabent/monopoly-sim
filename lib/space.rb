class Space
  def initialize(name)
    @name = name
    @hit_count = 0
  end
  
  def hit
    @hit_count += 1
  end
  
  def hit_count
    @hit_count
  end
end
