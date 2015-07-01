require 'pry'

module View
  BOARD_WIDTH = 8
  BOARD_HEIGHT = 8

  def self.display_board(board_str)
    rows = ('A'..'Z').to_a[0..BOARD_HEIGHT]
    cols = (1..26).to_a[0...BOARD_WIDTH]

    display = board_str.split("\n").map do |row|
      "#{rows.shift}" + row
    end.push(" #{cols.join}").join("\n")
    puts display
  end
end