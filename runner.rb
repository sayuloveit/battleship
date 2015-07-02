require_relative 'model/ship'
require_relative 'model/board'
require_relative 'model/bill'
require_relative 'view/view.rb'
require_relative 'module/module'

class BattleShip
  include CoordinateCheck

  def initialize(args = {})
    @player_ships = args.fetch(:player_ships)
    @opponent = args.fetch(:opponent)
    @player = args.fetch(:board_obj)
    run
  end

  def run
    player_setup
    turns
  end


  def player_setup
    until @player_ships.empty?
      puts "Your Board"
      View.display_board(@player.to_s)

      current_ship = @player_ships.shift

      begin
        puts "Please give a location and alignment to place your #{current_ship.class} (#{current_ship.hullpoints} spaces)"
        print "Location: "
        location = symbolify(gets.chomp)
        print "Alignment(h = horizonal, v = verticle): "
        alignment = gets.chomp
      end until @player.place_ship(current_ship, location, alignment)
    end

  end

  def turns
    until @player.game_over? || @opponent.game_over?

      puts "Bill's Board"
      View.display_board(@opponent.to_s)
      puts '-' * 10
      puts "Your Board"
      View.display_board(@player.to_s)

      print "pick a target: "
      input = gets.chomp
      @opponent.target(symbolify(input))


      winner = "You" if @opponent.game_over?


      puts "Bill is thinking..."
      sleep 1

      bills_target = @opponent.give_target
      target_result = @player.target(bills_target)
      @opponent.response(bills_target, target_result)
      # check
      puts "bill's target: #{bills_target}"
      puts "bill's target result: #{target_result}"
      puts "bill's last move: #{@opponent.last_hit}"
      puts "bill's priority targets: #{@opponent.priority_targets}"

      winner = "Bill" if @player.game_over?

    end

    puts "#{winner} won!"

  end

  private

  def symbolify(input)
    input.to_sym
  end


end


player_ships = [Carrier.new(player: true), Battleship.new(player: true), Cruiser.new(player: true), Submarine.new(player: true), Destroyer.new(player: true)]


bill = Bill.new
b_carrier = Carrier.new(player: true) #uncomment to see Bill's ships
b_battleship = Battleship.new(player: true) #uncomment to see Bill's ships
b_cruiser = Cruiser.new(player: true) #uncomment to see Bill's ships
b_submarine = Submarine.new(player: true) #uncomment to see Bill's ships
b_destroyer = Destroyer.new(player: true) #uncomment to see Bill's ships
bill.place_ships([b_carrier, b_battleship, b_cruiser, b_submarine, b_destroyer])


BattleShip.new({player_ships: player_ships, opponent: bill, board_obj: Board.new})
