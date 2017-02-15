# chess

![screenshot]

Console-based chess game that highlights available moves for the selected piece. To play, run `ruby game.rb`. Use the arrow keys to move the cursor and the space bar to confirm input. Note: does not implement castling or en passant.

### Technical Features

```ruby
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
```

```ruby
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
```

Classes for pieces include either the Slideable (Rook, Bishop, Queen) or Stepable (Knight, King) modules, above. The Pawn class is implemented separately:

```ruby
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
```

[screenshot]: ./screenshot.png
