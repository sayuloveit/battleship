require_relative 'board'
require 'pry'

class Bill < Board
  attr_reader :possible_moves, :last_hit, :last_move, :hits, :priority_targets

  def initialize
    super
    @possible_moves = @board.keys.select { |coord| valid_coord?(coord) }.shuffle
    @last_hit = nil
    @last_move = nil
    @hits = []
    @priority_targets = []
  end

  def give_target
    if @hits.length == 1      #targets area surrounding hit
      @priority_targets = surrounding_coordinates(@hits[0]).shuffle
      @possible_moves.delete(@priority_targets.shift)
    elsif @hits.length >= 2   #makes next hit
      @possible_moves.delete(next_hit(@hits[-2], @hits[-1]))
    else
      @last_move = @possible_moves.shift
    end
  end


  def response(hullpoints_left)
    if hullpoints_left == 0
      @possible_moves -= @hits
      @priority_targets.clear
      @hits.clear
    elsif !!hullpoints_left
      binding.pry
      @last_hit = @last_move
      @hits.push(@last_hit)
    else
      nil
    end
  end

  # private

  #determines next coordinates to target based on hits
  # def priority_targets
  #   if @hits.length == 1
  #     @priority_targets = surrounding_coordinates(@hits[0])
  #   elsif @hits.length >= 2
  #     next_hit(@hits[0], @hits[1])
  #   end
  # end

  def surrounding_coordinates(coordinate)
    x = coordinate[0]
    y = coordinate[1].to_i

    ["#{x}#{y - 1}", "#{x.succ}#{y}", "#{x}#{y + 1}", "#{previous_letter(x)}#{y}"].select { |coord| valid_coord?(coord) }.map(&:to_sym)
  end

  def previous_letter(letter)
    'a'.upto(letter).to_a[-2]
  end

  #calc next hit based on last two hits
  #todos: account for cases where it targets off the board
  def next_hit(hit1, hit2)
    if hit1[0] == hit2[0]
      hit1[1] < hit2[1] ? "#{hit2[0]}#{hit2[1].to_i + 1}".to_sym : "#{hit2[0]}#{hit2[1].to_i - 1}".to_sym
    else
      hit1[0] < hit2[0] ? "#{hit2[0].succ}#{hit2[1]}".to_sym : "#{previous_letter(hit2[0])}#{hit2[1]}".to_sym
    end
  end


end