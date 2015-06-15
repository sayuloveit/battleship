require 'colorize'
require_relative 'ship'
require 'pry'

class Board
  attr_reader :board
  def initialize
    @board = {
              :row1 => "A", :a1 => " ", :a2 => " ", :a3 => " ", :a4 => " ", :a5 => " ", :a6 => " ", :a7 => " ", :a8 => " ",
              :row2 => "B", :b1 => " ", :b2 => " ", :b3 => " ", :b4 => " ", :b5 => " ", :b6 => " ", :b7 => " ", :b8 => " ",
              :row3 => "C", :c1 => " ", :c2 => " ", :c3 => " ", :c4 => " ", :c5 => " ", :c6 => " ", :c7 => " ", :c8 => " ",
              :row4 => "D", :d1 => " ", :d2 => " ", :d3 => " ", :d4 => " ", :d5 => " ", :d6 => " ", :d7 => " ", :d8 => " ",
              :row5 => "E", :e1 => " ", :e2 => " ", :e3 => " ", :e4 => " ", :e5 => " ", :e6 => " ", :e7 => " ", :e8 => " ",
              :row6 => "F", :f1 => " ", :f2 => " ", :f3 => " ", :f4 => " ", :f5 => " ", :f6 => " ", :f7 => " ", :f8 => " ",
              :row7 => "G", :g1 => " ", :g2 => " ", :g3 => " ", :g4 => " ", :g5 => " ", :g6 => " ", :g7 => " ", :g8 => " ",
              :row8 => "H", :h1 => " ", :h2 => " ", :h3 => " ", :h4 => " ", :h5 => " ", :h6 => " ", :h7 => " ", :h8 => " "
              }
  end

  def place_ship(ship, coordinate, alignment)
    coordinates = ship_coordinates(ship, coordinate, alignment).select do |coord|
      valid_coord?(coord)
    end.select do |coord|
      occupied_coord?(coord)
    end

    if coordinates.length == ship.hullpoints
      coordinates.each { |coord| @board[coord] = ship }
      return true
    end

    false
  end

  def target(coordinate)
    # binding.pry
    #assume coordinate is present on board
    if hit?(coordinate)
      # binding.pry
      hullpoints_left = @board[coordinate].damage
      @board[coordinate] = 'X'.red
      return hullpoints_left
    else
      # binding.pry
      @board[coordinate] = 'O'.white
      false
    end
  end

  def game_over?
    ships_left = @board.values.select { |cell| !cell.kind_of?(String) }.length
    return true if ships_left == 0
  end

  def to_s
    @board.values.each_slice(9).to_a.unshift([" ", "1", "2", "3", "4", "5", "6", "7", "8"]).map do |row|
      row.map do |space|
        space
      end.join("|")
    end.join("\n")

  end

  # private

  #determines all coordinates a ship will take up
  def ship_coordinates(ship, coordinate, alignment)
    # binding.pry
    ship_length = ship.hullpoints
    positions = [coordinate]

    if alignment == 'h'
      (ship_length - 1).times do
        last_pos = positions.last
        positions << last_pos.succ
      end
    elsif alignment == 'v'
      (ship_length - 1).times do
        last_pos = positions.last
        positions << "#{last_pos[0].succ}#{last_pos[1]}"
      end
    end

    positions.map(&:to_sym)
  end

  def valid_coord?(coordinate)
    return true if (('a'..'h').include?(coordinate[0]) && ('1'..'8').include?(coordinate[1..-1]))
  end

  def occupied_coord?(coordinate)
    return true if @board[coordinate] == " "
  end

  def hit?(coordinate)
    !@board[coordinate].kind_of?(String)
  end

end