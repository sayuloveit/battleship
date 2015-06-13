require_relative 'model/ship'
require_relative 'model/board'
require_relative 'model/bill'


#turn position input into symbols
player_board = Board.new

player_carrrier = Carrier.new(player = true)
player_board.place_ship(player_carrrier, :a2, 'v')
player_board.target(:a1)
player_board.target(:a2)

puts player_board

p player_board


bill = Bill.new

bill_carrier = Carrier.new
bill.place_ship(bill_carrier, :a2, 'v')

#player hit bill
bill.target(:a1)
bill.target(:a3)
bill.target(:b2)

puts bill

p bill
