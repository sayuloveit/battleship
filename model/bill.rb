require_relative 'board'

class Bill < Board
  attr_reader :moves
  def initialize
    super
    @moves = Array.new
  end

  def bill_target(coordinate)
    @moves.push(coordinate)
    target(coordinate)
  end

end