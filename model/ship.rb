class Ship
  attr_reader :hullpoints

  def initialize(args = {})
    @hullpoints = args.fetch(:hullpoints)
    @player = args.fetch(:player)
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
    @player ? 'S'.blue : ' '
  end

end


class Carrier < Ship

  def initialize(hullpoints: 5, player: nil)
    super
  end

end

class Battleship < Ship

  def initialize(hullpoints: 4, player: nil)
    super
  end
end

class Cruiser < Ship

  def initialize(hullpoints: 3, player: nil)
    super
  end
end

class Submarine < Ship

  def initialize(hullpoints: 3, player: nil)
    super
  end

end

class Destroyer < Ship

  def initialize(hullpoints: 2, player: nil)
    super
  end

end
