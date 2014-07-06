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
        system "clear" or system "cls"
        turn()
      end
    end
  end


end

game = TicTacToe::Game.new(2, 5, {X: :h, Y: :h})
game.run()