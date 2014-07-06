module TicTacToe
   class Game
      def initialize(size)
          @board = Board.new(size)
      end
      
      def is_over?
         @board.each_cell { |b| print "1" }
      end
   end
end

game = new TicTacToe::Game(2)
game.is_over?