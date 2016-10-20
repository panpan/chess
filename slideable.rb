module Slideable
  def moves
    dirs.each_with_object([]) do |(dx, dy), moves|
      x, y = pos

      loop do
        x += dx
        y += dy
        end_pos = [x, y]

        break unless board.in_bounds?(end_pos)

        if board[end_pos].is_a?(NullPiece)
          moves << end_pos
        else
          moves << end_pos if board[end_pos].color != color
          break
        end
      end
    end
  end
end
