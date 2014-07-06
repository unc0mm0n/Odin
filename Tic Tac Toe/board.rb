module TicTacToe
    class Board
      attr_reader :board
      def initialize(size)
          @board = create_empty_board(size)
          @size = size
          p 'yo'
      end
      
      def print_board
          @size.times { print "-----" }
          puts
          @board.each do |row|
              row.each do |c|
                  print "| #{c} |"
              end
          puts
          @size.times { print "-----" }
          puts
          end
      end
      
      def make_move(move, sym)
        if board[x][y] == ' '
            board[x][y] = sym
        else
            raise ArgumentError, "Invalid, cell not empty"
        end
      end
      
      def each_in_row(row, &block)
          @board[row].each(&block)
      end
      
      def each_in_col(col, &block)
          @board.each { |row| block(row[col]) }
      end
  
      def each_cell(&block)
          @board.each { |row| row.each(&block) }
      end
      
      def [](index)
          @board[index]
      end
  
      def scoreMove(sym, x, y)
        score = relatives(sym, 1, x, y, 1, 0)
        p score
        score = relatives(sym, 1, x, y, 0, 1) 
        p score
        score = relatives(sym, 1, x, y, 1, 1) 
        p score
        score = relatives(sym, 1, x, y, 1, -1) 
        p score
      end
      
      def relatives(sym, current_score, x, y, dir_x, dir_y)
        p "yo #{current_score} at #{x} #{y}"
        if valid?(x+dir_x, y+dir_y) && @board[x+dir_x][y+dir_y] == sym
          current_score += relatives(sym, current_score,
                                     x+dir_x, y+dir_y, dir_x, dir_y)
        end
        if valid?(x-dir_x, y-dir_y) && @board[x-dir_x][y-dir_y] == sym
          current_score += relatives(sym, current_score,
                                     x-dir_x, y-dir_y, dir_x, dir_y)
        end
        current_score
      end
      
      def valid?(x, y)
        return true if (x > 0 && x < @size && y > 0 && y < @size)
        false
      end
    private
      def create_empty_board(size)
       board = Array.new
       size.times do
         row = Array.new
         size.times do
           row << ' '
         end
         board << row
        end
        board
      end
    end
end



board = TicTacToe::Board.new(3)
board.scoreMove(' ', 0, 0)