require_relative 'piece'

class Pawn < Piece
  def symbol
    "\u265F"
  end

  def moves
    advance.each_with_object([]) do |(dx, dy), moves|
      x, y = pos
      end_pos = [x + dx, y + dy]

      if board.in_bounds?(end_pos) && board[end_pos].is_a?(NullPiece)
        moves << end_pos
      end
    end + capture.each_with_object([]) do |(dx, dy), moves|
      x, y = pos
      end_pos = [x + dx, y + dy]

      next unless board.in_bounds?(end_pos)
      if !board[end_pos].is_a?(NullPiece) && board[end_pos].color != color
        moves << end_pos
      end
    end
  end

  private

  def advance
    if color == :white
      pos[0] == 6 ? [[-1, 0], [-2, 0]] : [[-1, 0]]
    else
      pos[0] == 1 ? [[1, 0], [2, 0]] : [[1, 0]]
    end
  end

  def capture
    color == :white ? [[-1, -1], [-1, 1]] : [[1, -1], [1, 1]]
  end
end
