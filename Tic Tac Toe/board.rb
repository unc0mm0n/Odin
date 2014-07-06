module TicTacToe
  class Board
    attr_reader :board
    def initialize(size)
      @board = create_empty_board(size)
      @size = size
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

    # set a cell to a given symbol IF it's blank (raies ArgumentError otherwise)
    # returns how many syms in a straight line the move creates
    def set_cell(x, y, sym)
      if board[x][y] == ' '
        board[x][y] = sym
        score_cell(x, y)
      else
        raise ArgumentError, "Invalid, cell not empty"
      end
    end

    def [](index)
      @board[index]
    end

    # scores a given cell based on how many syms in a row/collumn/diagonal
    # exits through the cell
    def score_cell(x, y)
      sym = @board[x][y]
      score = Array.new()
      temp_board = dupe_board
      score << relatives(temp_board, sym, 0, x, y, 1, 0)

      temp_board = dupe_board
      score << relatives(temp_board, sym, 0, x, y, 0, 1)

      temp_board = dupe_board
      score << relatives(temp_board, sym, 0, x, y, 1, 1)

      temp_board = dupe_board
      score << relatives(temp_board, sym, 0, x, y, 1, -1)

      return score.max
    end

    def valid?(x, y)
      return true if (x >= 0 && x < @size && y >= 0 && y < @size)
      false
    end
  private

    # Finds all squares that are the same :sym in a row, that are x_dir and y_dir apart from x and y
    def relatives(board, sym, current_score, x, y, dir_x, dir_y)
      # mark current cell as checked
      board[x][y] = nil

      # check if cell to given direction matches given sym
      if valid?(x+dir_x, y+dir_y) && board[x+dir_x][y+dir_y] == sym
        current_score = relatives(board, sym, current_score,
                                  x+dir_x, y+dir_y, dir_x, dir_y)
      end

      # check if cell to opposite direction matches given sym
      if valid?(x-dir_x, y-dir_y) && board[x-dir_x][y-dir_y] == sym
        current_score = relatives(board, sym, current_score,
                                  x-dir_x, y-dir_y, dir_x, dir_y)
      end

      # add current cell to count
      current_score + 1
    end

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

    def dupe_board
      Marshal.load(Marshal.dump(@board))
    end
  end
end