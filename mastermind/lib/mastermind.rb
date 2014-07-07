module Mastermind
  class Game

    DEFAULT_SIZE = 4
    DEFAULT_LIMIT = 12
    def initialize(player, args = {})
      args = { size: DEFAULT_SIZE, limit: DEFAULT_LIMIT }.merge(args)

      @size = args[:size]
      @code = args[:code]
      @limit = args[:limit]

      @code = Random.rand(10**(@size-1)...10**@size) unless @code
    end

    def guess()
      guess = player.getGuess(size)

      results = score_string(guess)
    end

    # Returns an array of syms representing the result
    #  :b => black (Correct char in correct location)
    #  :w => white (Correct char in wrong location)
    #  :m => miss (Wrong char)
    def score_string(guess)
      results = Array.new()
      guess.split('').each_with_index do |char, index|
        if char == @code[index]
          results[index] = :h
        elsif @code.include? char
          results[index] = :w
        else
          results[index] = :m
        end
      end
      results
    end

  end
end

g = Mastermind::Game.new('a', code: '2222')
p g.score_string('2f22')