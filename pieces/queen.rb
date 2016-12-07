require_relative '../piece'
require_relative '../slideable'

class Queen < Piece
  include Slideable

  def symbol
    "\u265B"
  end

  protected
  def dirs
    [[-1, -1],
     [-1, 0],
     [-1, 1],
     [0, -1],
     [0, 1],
     [1, -1],
     [1, 0],
     [1, 1]]
  end
end
