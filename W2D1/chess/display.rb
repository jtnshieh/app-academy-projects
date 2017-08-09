require 'colorize'
require_relative "cursor.rb"
require_relative "board.rb"
require_relative "piece.rb"

class Display

  def initialize(board)
    @cursor = Cursor.new([0,0], @board)
    @board = board
  end

  def build_grid
    @board.grid.map.with_index do |row, i|
      build_row(row, i)
    end
  end

  def build_row(row, i)
    row.map.with_index do |piece, j|
      color_options = colors_for(i, j)
      name = piece.name.to_s + " "
      name.colorize(color_options)
    end
  end

  def colors_for(i, j)
    if [i, j] == @cursor.cursor_pos && @cursor.selected
      bg = :light_green
    elsif [i, j] == @cursor.cursor_pos
      bg = :light_red
    elsif (i + j).odd?
      bg = :black
    else
      bg = :white
    end
    { background: bg }
  end

  def render
    system("clear")
    puts "Arrow keys, WASD, or vim to move, space or enter to confirm."
    build_grid.each { |row| puts row.join }

    # @notifications.each do |key, val|
    #   puts "#{val}"
    # end
  end

  # def render_rows(indices, color)
  #   indices.each do |idx|
  #     row = @board.grid[idx]
  #     if idx.even?
  #       row.each_with_index do |square, idx2|
  #         if idx2.even?
  #           print "#{square.name} ".colorize(:color => color, :background => :black)
  #         else
  #           print "#{square.name} ".colorize(:color => color, :background => :white)
  #         end
  #       end
  #     else
  #       row.each_with_index do |square, idx2|
  #         if idx2.even?
  #           print "#{square.name} ".colorize(:color => color, :background => :white)
  #         else
  #           print "#{square.name} ".colorize(:color => color, :background => :black)
  #         end
  #       end
  #     end
  #     print "\n"
  #   end
  #
  # end

  # def render
  #   render_rows((0..5).to_a, :light_red)
  #   render_rows([6, 7], :light_blue)
  #   @board[@cursor.cursor_pos]
  # end

end

a = Board.new
Display.new(a).render
