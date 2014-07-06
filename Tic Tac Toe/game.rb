require_relative 'board'
require_relative 'player'
module TicTacToe
  class Game

    attr_reader :board, :players

    # start a game with given board size
    # and players hash:
    #  :sym => :player_type
    def initialize(size, win_size, players={:x => :h, :o => :h})
      @board = Board.new(size)
      @moves_left = size ** 2
      @game_over = false

      if win_size > size
        puts '======================================================'
        puts '= Warning: winning size too large, board unwinnable! ='
        puts '======================================================'
      end
      @win_size = win_size

      @players = Array.new
      players.each do |key, val|
        if val == :h
          @players << HumanPlayer.new(key)
        elsif val == :c
          @players << ComputerPlayer.new(key)
        else
          print 'Unknown player type "#{val}" (h for human, c for computer)'
        end
      end
    end

    def turn()
      puts "#{@players.first.sym}'s turn!"
      board.print_board
      valid = false
      # make player move
      until valid do
      # try and get a valid move format
        begin
          move = @players.first.make_move()
        rescue ArgumentError => e
          puts e
          next
        end

        # check if move on board
        move.map! { |m| m - 1 }
        unless board.valid?(move[1], move[0])
          puts "Invalid square, not on board"
          next
        end

        # try and make the move on the board
        begin
          score = board.set_cell(move[1], move[0], @players.first.sym)
        rescue ArgumentError => e
          puts e
          next
        end

        valid = true
      end

      # check if move is winning
      if score == @win_size
        board.print_board
        puts "#{@players.first.sym} has won!"
        @game_over = true
      end

      @moves_left -= 1
      if @moves_left == 0
        board.print_board
        puts "It's a tie!!!"
        @game_over = true
      end

      @players.push(@players.shift)
    end

    def run()
      until @game_over
        turn()
      end
    end

    def to_s
      print "Size: #{@board.size}, Win size: #{@win_size}, "
      print "Players: #{players.map {|f| f.sym}.join(', ')}, Moves left: #{@moves_left}"
    end
  end


end

puts "hey there bud!"
play = true
while play
  print "What board size do you want to have? "
  size = gets.chomp.to_i

  print "And how many tiles in a row are needed to win? "
  win_size = gets.chomp.to_i

  puts "You are doing great!"
  print "How many human players should we have today? "
  players = Hash.new()
  for i in (1..gets.chomp.to_i) do
    print "Player #{i}'s symbol: "
    players[gets.chomp.to_s] = :h
  end

  print "How many computer players should we have today? "
  for i in (1..gets.chomp.to_i) do
    print "Player #{i}'s symbol: "
    puts "NOT YET IMPLEMENTED"
  end

  game = TicTacToe::Game.new(size, win_size, players)
  puts "Your game is ready!"
  puts game.to_s
  game.run()

  print "Do you want to play again?"
  play = (gets.chomp =~ /^Ay/i)
end