require_relative 'ship'

class Board

  def initialize
    @board = {
              :a1 => " ", :a2 => " ", :a3 => " ", :a4 => " ", :a5 => " ", :a6 => " ", :a7 => " ", :a8 => " ",
              :b1 => " ", :b2 => " ", :b3 => " ", :b4 => " ", :b5 => " ", :b6 => " ", :b7 => " ", :b8 => " ",
              :c1 => " ", :c2 => " ", :c3 => " ", :c4 => " ", :c5 => " ", :c6 => " ", :c7 => " ", :c8 => " ",
              :d1 => " ", :d2 => " ", :d3 => " ", :d4 => " ", :d5 => " ", :d6 => " ", :d7 => " ", :d8 => " ",
              :e1 => " ", :e2 => " ", :e3 => " ", :e4 => " ", :e5 => " ", :e6 => " ", :e7 => " ", :e8 => " ",
              :f1 => " ", :f2 => " ", :f3 => " ", :f4 => " ", :f5 => " ", :f6 => " ", :f7 => " ", :f8 => " ",
              :g1 => " ", :g2 => " ", :g3 => " ", :g4 => " ", :g5 => " ", :g6 => " ", :g7 => " ", :g8 => " "
              }
  end

  def place_ship(ship, location)

  end


  def to_s
    @board.values.each_slice(8).to_a.map do |row|
      row.join("|")
    end.join("\n")
  end

end