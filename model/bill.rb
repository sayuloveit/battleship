require_relative 'board'

class Bill < Board

  def initialize
    super
    @possible_moves = @board.keys.select { |coord| valid_coord?(coord) }.shuffle
    @last_move = nil
    @hits = []
    @priority_targets = []
  end

  def give_target
    if @hits.length == 1
      #give next target

    elsif @hits.length == 2

    else
      @last_move = @possible_moves.shift
    end
  end


  def response(hullpoints_left)
    if hullpoints_left == 0
      @possible_moves -= (@hits + @priority_targets)
      @priority_targets.clear
      @hits.clear
    elsif !!hullpoints_left
      @hits.push(@last_move)
    else

    end
  end

  # private

  #determines next coordinates to target based on hits
  def priority_targets
    if @hits.length == 1
      @priority_targets = surrounding_coordinates(@hits[0])
    elsif @hits.length >= 2

    end
  end

  def surrounding_coordinates(coordinate)
    x = coordinate[0]
    y = coordinate[1].to_i

    ["#{x}#{y - 1}"  , "#{x.succ}#{y}", "#{x}#{y + 1}", "#{previous_letter(x)}#{y}"].select { |coord| valid_coord?(coord) }.map(&:to_sym)
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