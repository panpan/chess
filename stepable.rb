module Stepable
  def moves
    steps.each_with_object([]) do |(dx, dy), moves|
      x, y = pos
      end_pos = [x + dx, y + dy]

      next unless board.in_bounds?(end_pos)

      if board[end_pos].is_a?(NullPiece) || board[end_pos].color != color
        moves << end_pos
      end
    end
  end
end
