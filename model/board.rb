require 'colorize'
require_relative 'ship'
require 'pry'

class Board
  attr_reader :board
  BOARD_WIDTH = 8
  BOARD_HEIGHT = 8

  def initialize
    @board = generate_keys.each_with_object({}) { |key, hash| hash[key] = nil }
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
    xs = 'X'.red
    os = 'O'.white
    # binding.pry
    #assume coordinate is present on board
    if hit?(coordinate)
      # binding.pry
      hullpoints_left = @board[coordinate].damage
      @board[coordinate] = xs
      return hullpoints_left
    else
      if @board[coordinate] == xs
        true
      elsif @board[coordinate] == os
        false
      else
        @board[coordinate] = os
        false
      end
    end
  end

  def game_over?
    ships_left = @board.values.select { |cell| !cell.kind_of?(String) }.length
    return true if ships_left == 0
  end


  def to_s
    @board.values.each_slice(BOARD_WIDTH).map(&:join).join("\n")
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
    ('a'..'z').to_a[0...BOARD_WIDTH].include?(coordinate[0]) && ('1'..'26').to_a[0...BOARD_HEIGHT].include?(coordinate[1..-1])
  end

  def occupied_coord?(coordinate)
    @board[coordinate].nil?
  end

  def hit?(coordinate)
    # !@board[coordinate].kind_of?(String)

    !@board[coordinate].nil?
  end

  # private
  def generate_keys
    rows = ('a'..'z').to_a[0...BOARD_WIDTH].map { |i| i * BOARD_WIDTH }.map(&:chars)
    columns = (('1'..'26').to_a[0...BOARD_HEIGHT] * BOARD_HEIGHT).each_slice(BOARD_HEIGHT).to_a
    # binding.pry

    rows.flatten.zip(columns.flatten).map(&:join).map(&:to_sym)
  end

end