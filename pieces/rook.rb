require_relative '../piece'
require_relative '../slideable'

class Rook < Piece
  include Slideable

  def symbol
    "\u265C"
  end

  protected
  def dirs
    [[-1, 0],
     [1, 0],
     [0, -1],
     [0, 1]]
  end
end
