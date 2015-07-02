require_relative 'ship'
require_relative '../module/module'
require 'pry'

class Board
  include CoordinateCheck
  attr_reader :board
  # BOARD_WIDTH = 8
  # BOARD_HEIGHT = 8
  HIT = 'X'
  MISS = 'O'

  def initialize
    @board = generate_coords.each_with_object({}) { |key, hash| hash[key] = ' ' }
  end

  def place_ship(ship, coordinate, alignment)
    coordinates = ship_coordinates(ship, coordinate, alignment).select do |coord|
      valid_coord?(coord)
    end.select { |coord| unoccupied_coord?(coord) }

    if coordinates.length == ship.hullpoints
      coordinates.each { |coord| @board[coord] = ship }
      return true
    end

    false
  end

  def target(coordinate)
    #assume coordinate is present on board
    if hit?(coordinate)
      hullpoints_left = @board[coordinate].damage
      @board[coordinate] = HIT
      hullpoints_left
    else
      return false if @board[coordinate] == HIT || @board[coordinate] == MISS
      @board[coordinate] = MISS
      false
    end
  end

  def game_over?
    ships_left = @board.values.select { |cell| !cell.nil? && !cell.kind_of?(String) }
    ships_left.empty?
  end


  def to_s
    @board.values.each_slice(BOARD_WIDTH).map(&:join).join("\n")
  end

  # private

  #determines all coordinates a ship will take up
  def ship_coordinates(ship, coordinate, alignment)
    ship_length = ship.hullpoints
    positions = [coordinate]

    (ship_length - 1).times do
        last_pos = positions.last
        if alignment == 'h'
          next_pos = last_pos.succ
        elsif alignment == 'v'
          next_pos = "#{last_pos[0].succ}#{last_pos[1]}"
        end
        positions << next_pos
    end

    positions.map(&:to_sym)
  end

  def unoccupied_coord?(coordinate)
    @board[coordinate].is_a?(String)
  end

  def hit?(coordinate)
    !@board[coordinate].is_a?(String)
  end

  def generate_coords
    rows = ('a'..'z').to_a[0...BOARD_WIDTH].map { |i| i * BOARD_WIDTH }.map(&:chars)
    columns = (('1'..'26').to_a[0...BOARD_HEIGHT] * BOARD_HEIGHT).each_slice(BOARD_HEIGHT).to_a

    rows.flatten.zip(columns.flatten).map(&:join).map(&:to_sym)
  end

end
