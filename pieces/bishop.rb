require_relative '../piece'
require_relative '../slideable'

class Bishop < Piece
  include Slideable

  def symbol
    "\u265D"
  end

  protected
  def dirs
    [[-1, -1],
     [-1, 1],
     [1, -1],
     [1, 1]]
  end
end
