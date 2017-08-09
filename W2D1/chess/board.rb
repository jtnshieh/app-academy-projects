require_relative 'piece.rb'

class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { [] }
    populate
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    @grid[row][col] = value
  end

  def populate
    8.times { @grid[0] << Piece.new("p") }

    8.times { @grid[1] << Piece.new("\u265F".encode('utf-8')) }

    (2..5).each do |idx|
      8.times { @grid[idx] << Piece.new }
    end

    8.times { @grid[6] << Piece.new("\u265F".encode('utf-8')) }

    8.times { @grid[7] << Piece.new("p") }
  end

  def move_piece(start_pos, end_pos)
    if self[start_pos] == nil
      raise "There is no piece at this position."
    elsif self[end_pos] != nil
      raise "There is already a piece at this position."
    #if start or end position if off the Board
    #if the piece does not move in that way
    end
    self[end_pos] = self[start_pos]
    self[start_pos] = nil
  end

  def in_bounds?(position)
    valid = (0..7).to_a

    unless valid.include?(position[0])
      return false
    end

    unless valid.include?(position[1])
      return false
    end

    true
  end
end
