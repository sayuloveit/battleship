class Ship
  attr_accessor :hullpoints

  def initialize(hullpoints = nil)
    @hullpoints = hullpoints
    @float = true
  end

  def damage
    @hullpoints -= 1
  end

  def afloat?
    @float = false if @hullpoints <= 0
    @float
  end

end


class Carrier < Ship

  def initialize(hullpoints = 5)
    super
  end
end

class Battleship < Ship

  def initialize(hullpoints = 4)
    super
  end
end

class Cruiser < Ship

  def initialize(hullpoints = 3)
    super
  end
end

class Submarine < Ship

  def initialize(hullpoints = 3)
    super
  end

end

class Destroyer < Ship

  def initialize(hullpoints = 2)
    super
  end

end