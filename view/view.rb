require 'pry'

module View
  BOARD_WIDTH = 8
  BOARD_HEIGHT = 8

  def self.display_board(board_str)
    rows = ('A'..'Z').to_a[0..BOARD_HEIGHT]
    cols = (1..26).to_a[0...BOARD_WIDTH]

    display = board_str.chars.each_slice(BOARD_WIDTH).to_a.map do |row|
      row.unshift(rows.shift)
    end.map(&:join).join("\n")
    # binding.pry
    puts display
  end
end