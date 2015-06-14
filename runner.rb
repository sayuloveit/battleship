require_relative 'model/ship'
require_relative 'model/board'
require_relative 'model/bill'

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


  winner = "You" if bill.game_over?


  puts "Bill is thinking..."
  sleep 1

  bills_target = bill.give_target
  target_result = p1.target(bills_target)
  bill.response(bills_target, target_result)
  # puts "bill's target: #{bills_target}"
  # puts "bill's target result: #{target_result}"
  # puts "bill's last move: #{bill.last_hit}"
  # puts "bill's priority targets: #{bill.priority_targets}"

  winner = "Bill" if p1.game_over?

end

puts "#{winner} won!"