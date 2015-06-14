require_relative 'board'

class Bill < Board
  attr_reader :moves
  def initialize
    super
    @avaiable_moves = @board.keys.select { |coord| valid_coord?(coord) }
    @moves = Array.new
    @hits = Array.new
  end

  def bill_target(coordinate)
    @moves.push(coordinate)
    target(coordinate)
  end


  private

  # def

  # end

end