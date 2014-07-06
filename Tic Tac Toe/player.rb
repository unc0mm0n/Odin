module TicTacToe
  class Player

    attr_reader :sym, :name
    def initialize(sym)
      @sym = sym
      @name = name
    end
  end

  #Prompts user for a move of N N format.
  #Raises Invalid input format argument error
  class HumanPlayer < Player
    def make_move()
      print "Make your move (row column): "
      move = gets.chomp
      unless move =~ /\d+\s+\d+/
          raise ArgumentError, "Invalid input format, expected \"NN NN\""
      end
      move = move.split(/\s+/).map { |m| m.to_i unless m.empty? }
      return move.select {|m| m }

    end
  end
end