require_relative 'board.rb'

class Piece

  attr_accessor :name

  def initialize(name = " ")
    @name = name
    @moves = []
  end

  def moves
    @moves
  end
end

  module SlidingPiece
    def moves
    end

    def move_dir
    end

    def horizontal_dirs
    end

    def diagonal_dirs
    end

    def grow_unblocked_moves_in_dir(dx, dy)
    end

  end


  class Bishop < Piece
    include SlidingPiece

    def initialize
      super("U\265D".encode('utf-8'))
    end
  end

  class Rook < Piece
    include SlidingPiece
    def initialize
      super("U\265C".encode('utf-8'))
    end
  end

  class Queen < Piece
    include SlidingPiece
    def initialize
      super("U\265B".encode('utf-8'))
    end

  end



  module SteppingPiece
    def moves
    end

    def move_dirs

    end
  end

  class Pawn < Piece
    include SteppingPiece
    def initialize
      super("♟")
    end
  end

  class Knight < Piece
    include SteppingPiece
    def initialize
      super("U\265E".encode('utf-8'))
    end
  end

  class King < Piece
    include SteppingPiece
    def initialize
      super("U\265A".encode('utf-8'))
    end
  end

  # class NullPiece < Piece
  #   include Singleton
  #
  #   def initialize
  #     @color = nil
  #     super(" ")
  #   end
  #
  # end
