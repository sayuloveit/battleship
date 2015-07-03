require_relative 'board'
require_relative '../module/module'
require 'pry'

#to dos
#make Bill stop target the other direction once there is a miss while hunting

class Bill
  include CoordinateCheck
  attr_reader :possible_targets, :priority_targets, :last_hits, :board, :hunting

  def initialize(args = {})
    @board = args.fetch(:board)
    @all_targets = @board.board.keys.select { |coord| valid_coord?(coord) }.shuffle
    @last_hits = []
    @priority_targets = []
    @possible_targets = []
    @hunting = false   #detemines when to stop using priority targets
  end

  # gives a target and remove it from possible moves
  def give_target
    if @hunting
      target = @priority_targets.first
      if target.nil?
        @hunting = false
        target = @all_targets.first
      end
    else
      target = @all_targets.first
    end

    target
  end


  def response(last_target, hullpoints_left)
      if hullpoints_left == 0
        @last_hits.clear
        @priority_targets.clear
        @possible_targets.clear
        @hunting = false
      elsif !!hullpoints_left && @last_hits.length == 0
        @last_hits << last_target
        @priority_targets = possible_targets(last_target, 1).shuffle
        @possible_targets = possible_targets(last_target, hullpoints_left)
        @hunting = true
      elsif !!hullpoints_left && @last_hits.length == 1
        @last_hits << last_target
        @priority_targets = col_or_row_filter(@last_hits, @possible_targets)
      elsif !!hullpoints_left
        @last_hits << last_target
      end

      @priority_targets.delete(last_target)
      @all_targets.delete(last_target)
  end

  # randomly place ships
  def place_ships(ships)
    ships.each do |ship|
      until @board.place_ship(ship, @all_targets.sample, ['v', 'h'].sample)
      end
    end
  end

  def to_s
    @board.to_s
  end

  # private

  # narrow down coordinates to hit based on info from last hit
  def possible_targets(hit_coordinate, hullpoints_left)
    row = hit_coordinate[0]
    col = hit_coordinate[1].to_i
    result = []

    ['u', 'd', 'l', 'r'].each do |direction|
      result.concat(n_direction_coordinates(hit_coordinate, hullpoints_left, direction))
    end

    result.select{ |coord| valid_coord?(coord) && @all_targets.include?(coord.to_sym) }.map(&:to_sym)
  end

  def previous_letter(letter)
    'a'.upto(letter).to_a[-2]
  end

  # determines next coordinates base on direction
  def next_coordinate(coordinate, direction)
    row = coordinate[0]
    col = coordinate[1].to_i
    case direction
      when 'l'            #left
        "#{row}#{col - 1}"
      when 'r'            #right
        "#{row}#{col + 1 }"
      when 'u'            #up
        "#{previous_letter(row)}#{col}"
      when 'd'            #down
        "#{row.succ}#{col}"
    end
  end

  # generates next n coordinates based on starting coordinate and direction
  def n_direction_coordinates(coordinate, n, direction)
    result = [next_coordinate(coordinate, direction)]
    (n - 1).times { result << next_coordinate(result[-1], direction) }
    result
  end

  # takes in two consecutive row or col coordinates, filters coordinates
  # that are not in the same column or row
  def col_or_row_filter(two_consec_coords, coords_to_filter)
    coord1, coord2 = two_consec_coords

    if coord1[0] == coord2[0]     #same row
      coords_to_filter.select { |coord| coord[0] == coord1[0] && @all_targets.include?(coord) }
    elsif coord1[1] == coord2[1]  #same col
      coords_to_filter.select { |coord| coord[1] == coord1[1] && @all_targets.include?(coord) }
    end
  end


end
