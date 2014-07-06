module TicTacToe
   class Game
      def initialize(size)
          @board = Board.new(size)
          @move_count = 0
      end
      
      def is_tie?
         @move_count == size
      end
   end
end

game = new TicTacToe::Game(2)
game.is_tie?