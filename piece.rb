require 'colorize'
require_relative 'board'

class Piece
  attr_reader :color, :board
  attr_accessor :pos

  def initialize(color, board, pos)
    @color, @board, @pos = color, board, pos
    board.place_piece(self, pos)
  end

  def to_s
    symbol = "#{self.symbol.force_encoding('utf-8')} "

    if self.color == :white
      symbol.colorize(:light_white)
    else
      symbol.colorize(:black)
    end
  end

  def valid_moves
    moves.reject { |end_pos| move_into_check?(end_pos) }
  end

  private
  def move_into_check?(end_pos)
    test_board = board.dup
    test_board.move!(self.pos, end_pos)
    test_board.in_check?(self.color)
  end
end
