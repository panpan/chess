require_relative 'piece'
require_relative 'slideable'

class Rook < Piece
  include Slideable

  def symbol
    "\u265C"
  end

  protected
  def dirs
    [[-1, 0], [1, 0], [0, -1], [0, 1]]
  end
end

class Bishop < Piece
  include Slideable

  def symbol
    "\u265D"
  end

  protected
  def dirs
    [[-1, -1], [-1, 1], [1, -1], [1, 1]]
  end
end

class Queen < Piece
  include Slideable

  def symbol
    "\u265B"
  end

  protected
  def dirs
    [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]
  end
end
