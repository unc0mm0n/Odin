module Mastermind
  class Game

    require_relative 'player'
    require 'colorize'
    DEFAULT_SIZE = 4
    DEFAULT_LIMIT = 12
    def initialize(args = {})
      args = { size: DEFAULT_SIZE, limit: DEFAULT_LIMIT, player: :human, sort: false }.merge(args)

      @player = HumanPlayer.new

      @code = args[:code]
      @size = args[:size]
      @size = @code.length if @code
      @guess_count = 1
      @limit = args[:limit]
      @sort = args[:sort]
      p @sort

      @code = Random.rand(10**(@size-1)...10**@size).to_s unless @code

      @game_over = false
    end

    def turn()
      puts "Try #{@guess_count} out of #{@limit}: "
      guess = @player.guessMove(@size)

      if guess == 'cheat'
        puts @code
      else
        results = score_string(guess)
        results.sort! if @sort

        puts "\nevaluating...  "
        results.each do |result|

          print result.to_s.green if result == :h
          print result.to_s.yellow if result == :n
          print result.to_s.red if result == :m
          print ' '
          sleep 0.5
        end
        puts "\n\n"

        if results.all? {|f| f == :h}
          print 'You have won!'
          return @game_over = true
        end
      end

      @guess_count += 1
      if @guess_count > @limit
        puts "You ran out of tries, you lost!"
        print "The code was #{@code}"
        return @game_over = true
      end
    end

    def run()
      until @game_over
        turn()
      end
    end

  private
    # Returns an array of syms representing the result
    #  :h => hit (Correct char in correct location)
    #  :n => near (Correct char in wrong location)
    #  :m => miss (Wrong char)
    def score_string(guess)
      results = Array.new()
      guess.split('').each_with_index do |char, index|
        if char == @code[index]
          results[index] = :h
        elsif @code.include? char
          results[index] = :n
        else
          results[index] = :m
        end
      end
      results
    end

  end
end

g = Mastermind::Game.new(size: 8, limit: 12, sort: false)
g.run()