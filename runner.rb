require_relative 'model/ship'
require_relative 'model/board'
require_relative 'model/bill'
require 'pry'

def symbolify(input)
  input.to_sym
end

#turn position input into symbols
p1 = Board.new

p_carrier = Carrier.new(player = true)
p_battleship = Battleship.new(player = true)
p_cruiser = Cruiser.new(player = true)
p_submarine = Submarine.new(player = true)
p_destroyer = Destroyer.new(player = true)

# binding.pry
p1.place_ship(p_carrier, :a2, 'v')
p1.place_ship(p_battleship, :g1, 'h')
p1.place_ship(p_cruiser, :a8, 'v')
p1.place_ship(p_submarine, :e5, 'h')
p1.place_ship(p_destroyer, :b4, 'h')



bill = Bill.new
b_carrier = Carrier.new
bill.place_ship(b_carrier, :a2, 'v')

until p1.game_over? || bill.game_over?

  puts "Bill's Board"
  puts bill
  puts '-' * 10
  puts "Your Board"
  puts p1


  print "pick a target: "
  input = gets.chomp
  bill.target(symbolify(input))

  puts "Bill is thinking..."
  sleep 1

  target = p1.target(bill.give_target)
  bill.response(target)
  puts "bill's target: #{target}"
  # puts "bill's response: #{bill.response(target)}"
  puts "bill's last move: #{bill.last_move}"
  puts "bill's hits: #{bill.hits}"
  puts "bill's priority targets: #{bill.priority_targets}"

end
