require_relative './model/ship'
require_relative './model/board'


#turn position input into symbols
player_board = Board.new

s = Carrier.new(player = true)
player_board.place_ship(s, :a2, 'v')
player_board.target(:a1)
player_board.target(:a2)

puts player_board

p player_board
