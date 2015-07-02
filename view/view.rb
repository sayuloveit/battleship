require 'pry'
require 'colorize'

module View
  BOARD_WIDTH = 8
  BOARD_HEIGHT = 8

  def self.display_board(board_str)
    rows = ('A'...'Z').to_a[0..BOARD_HEIGHT]
    cols = (1..26).to_a[0...BOARD_WIDTH]
<<<<<<< HEAD

    color_board = board_str.chars.map { |coord| add_color(coord) }.join

    display = color_board.split("\n").map do |row|
      "#{rows.shift}" + row
    end.push(" #{cols.join}").join("\n")

    puts display
  end

  def self.add_color(coord)
    if coord == 'X'
      coord.red
    elsif coord == 'O'
      coord.white
    else
      coord
    end
  end

end
=======
    display = board_str.split("\n").map(&:chars).map do |row|
      row.unshift(rows.shift)
    end.map(&:join).push(" #{(1..BOARD_WIDTH).to_a.join}").join("\n")

    puts display
  end
end
>>>>>>> ba1fc6bdaeb9c5b4586c4948731c6a3dd80aff78
