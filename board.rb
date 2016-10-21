require_relative 'rook'
require_relative 'knight'
require_relative 'bishop'
require_relative 'queen'
require_relative 'king'
require_relative 'pawn'
require_relative 'null'

class Board
  attr_reader :grid

  def initialize(fill = false)
    @sentinel = NullPiece.instance
    @grid = Array.new(8) { Array.new(8, sentinel) }
    fill_grid if fill
  end

  def [](pos)
    x, y = pos
    grid[x][y]
  end

  def []=(pos, piece)
    x, y = pos
    grid[x][y] = piece
  end

  def place_piece(piece, pos)
    self[pos] = piece
  end

  def move!(start_pos, end_pos)
    piece = self[start_pos]
    self[end_pos] = piece
    self[start_pos] = sentinel
    piece.pos = end_pos
    nil
  end

  def move(curr_player, start_pos, end_pos)
    raise 'empty square' if self[start_pos].is_a?(NullPiece)

    piece = self[start_pos]
    if piece.color != curr_player
      raise 'not your piece'
    elsif !piece.moves.include?(end_pos)
      raise 'illegal move'
    elsif !piece.valid_moves.include?(end_pos)
      raise "can't move into check"
    end

    move!(start_pos, end_pos) if self[start_pos].valid_moves.include?(end_pos)
  end

  def pieces
    grid.flatten.reject { |p| p.is_a?(NullPiece) }
  end

  def dup
    new_board = Board.new
    pieces.each { |p| p.class.new(p.color, new_board, p.pos) }
    new_board
  end

  def in_check?(color)
    king_pos = find_king(color).pos
    pieces.any? { |p| p.color != color && p.moves.include?(king_pos) }
  end

  def checkmate?(color)
    return false unless in_check?(color)
    pieces.select { |p| p.color == color }.all? { |p| p.valid_moves.empty? }
  end

  def in_bounds?(pos)
    pos.all? { |coord| coord.between?(0, 7) }
  end

  private
  attr_reader :sentinel

  def fill_back_row(color)
    pieces = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    i = color == :white ? 7 : 0
    pieces.each_with_index { |p, j| p.new(color, self, [i, j]) }
  end

  def fill_pawn_row(color)
    i = color == :white ? 6 : 1
    8.times { |j| Pawn.new(color, self, [i, j]) }
  end

  def fill_grid
    [:white, :black].each do |color|
      fill_back_row(color)
      fill_pawn_row(color)
    end
  end

  def find_king(color)
    pieces.find { |p| p.color == color && p.is_a?(King) }
  end
end
