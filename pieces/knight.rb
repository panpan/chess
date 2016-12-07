require_relative '../piece'
require_relative '../stepable'

class Knight < Piece
  include Stepable

  def symbol
    "\u265E"
  end

  protected
  def steps
    [[-2, -1],
     [-2, 1],
     [-1, -2],
     [-1, 2],
     [1, -2],
     [1, 2],
     [2, -1],
     [2, 1]]
  end
end
