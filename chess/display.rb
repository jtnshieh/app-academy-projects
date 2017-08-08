require 'colorize'
require_relative "cursor.rb"
require_relative "board.rb"
require_relative "piece.rb"

class Display

  def initialize(board)
    @cursor = Cursor.new([0,0], @board)
    @board = board
  end

  def render
    evens = [0,2,4,6]
    odds = [1,3,5,7]
    evens.each do |idx|
      evens.each do |idx2|
        if @board.grid[idx][idx2] == nil
          print "a ".colorize(:color => :white, :background => :black)
        else
          print "#{@board.grid[idx][idx2].name} ".colorize(:color => :white, :background => :black)
        end
      end
      puts "\n"
    end
    odds.each do |idx|
      odds.each do |idx2|
        if @board.grid[idx][idx2] == nil
          print "a ".colorize(:color => :black, :background => :white)
        else
          print "#{@board.grid[idx][idx2].name} ".colorize(:color => :black, :background => :white)
        end
      end
      puts "\n"
    end
  end
end
