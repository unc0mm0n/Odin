module Mastermind

  class Player
    def initialize(name='Player')
      @name = name
    end

  end

  class HumanPlayer < Player
    def guessMove(size)
      guess = ''
      until guess.length == size
        print "Guess your code (size #{size}): "
        guess = gets.chomp
        break if guess == 'cheat'
      end

      guess
    end
  end
end

