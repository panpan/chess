require_relative '../piece'
require_relative '../stepable'

class King < Piece
  include Stepable

  def symbol
    "\u265A"
  end

  protected
  def steps
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
