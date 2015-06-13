class Ship
  attr_accessor :hullpoints

  def initialize(player = nil, hullpoints = nil)
    @hullpoints = hullpoints
    @player = player
    @float = true
  end

  def damage
    @hullpoints -= 1
  end

  def afloat?
    @float = false if @hullpoints <= 0
    @float
  end

  def to_s
    @player ? "S".blue : " "
  end

end


class Carrier < Ship

  def initialize(player = nil, hullpoints = 5)
    super
  end

end

class Battleship < Ship

  def initialize(player = nil, hullpoints = 4)
    super
  end
end

class Cruiser < Ship

  def initialize(player = nil, hullpoints = 3)
    super
  end
end

class Submarine < Ship

  def initialize(player = nil, hullpoints = 3)
    super
  end

end

class Destroyer < Ship

  def initialize(player = nil, hullpoints = 2)
    super
  end

end