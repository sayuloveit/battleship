require_relative 'model/ship'
require_relative 'model/board'
require_relative 'model/bill'

def symbolify(input)
  input.to_sym
end

p1 = Board.new

ships = [Carrier.new(player = true), Battleship.new(player = true), Cruiser.new(player = true), Submarine.new(player = true), Destroyer.new(player = true)]

until ships.empty?
  puts "Your Board"
  puts p1

  current_ship = ships.shift

  begin
    puts "Please give a location and alignment to place your #{current_ship.class} (#{current_ship.hullpoints} spaces)"
    print "Location: "
    location = symbolify(gets.chomp)
    print "Alignment(h = horizonal, v = verticle): "
    alignment = gets.chomp
  end until p1.place_ship(current_ship, location, alignment)

end


bill = Bill.new
b_carrier = Carrier.new(player = true) #uncomment to see Bill's ships
b_battleship = Battleship.new(player = true) #uncomment to see Bill's ships
b_cruiser = Cruiser.new(player = true) #uncomment to see Bill's ships
b_submarine = Submarine.new(player = true) #uncomment to see Bill's ships
b_destroyer = Destroyer.new(player = true) #uncomment to see Bill's ships
bill.place_ships([b_carrier, b_battleship, b_cruiser, b_submarine, b_destroyer])

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
  puts "bill's target: #{bills_target}"
  puts "bill's target result: #{target_result}"
  puts "bill's last move: #{bill.last_hit}"
  puts "bill's priority targets: #{bill.priority_targets}"

  winner = "Bill" if p1.game_over?

end

puts "#{winner} won!"