require_relative 'board'
require_relative 'player'
module TicTacToe
  class Game

    attr_reader :board, :players

    # start a game with given board size
    # and players hash:
    #  :sym => :player_type
    def initialize(size, players={:x => :h, :o => :h})

      @board = Board.new(size)
      @moves_left = size ** 2

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


    def is_tie?
      @moves_left == 0
    end
  end
end

game = TicTacToe::Game.new(2, {x: :h, o: :h})
p game.is_tie?
p game.board
p game.players