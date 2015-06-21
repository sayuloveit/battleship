require_relative 'board'
require 'pry'

class Bill < Board
  attr_reader :possible_targets, :priority_targets, :last_hit

  def initialize
    super
    @possible_targets = @board.keys.select { |coord| valid_coord?(coord) }.shuffle
    @last_hit = nil
    @priority_targets = []
    @hunting = false   #detemines when to stop using priority targets
  end

  # gives a target and remove it from possible moves
  def give_target
    if @hunting
      target = @priority_targets.shift
      if !!target
        @possible_targets.delete(target)
      else
        @hunting = false
        @possible_targets.shift
      end
    else
      @possible_targets.shift
    end
  end


  def response(last_target, hullpoints_left)
      if hullpoints_left == 0
        @hunting = false
        @priority_targets.clear
      elsif !!hullpoints_left
        @hunting = true
        if @priority_targets.empty?
          @last_hit = last_target
          @priority_targets = possible_targets(@last_hit, hullpoints_left).shuffle
        end
      end
  end

  # randomly place ships
  def place_ships(ships)
    ships.each do |ship|
      until place_ship(ship, @possible_targets.sample, ['v', 'h'].sample)
      end
    end
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

    result.select{ |coord| valid_coord?(coord) }.map(&:to_sym)
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


end