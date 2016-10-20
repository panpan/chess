require 'colorize'
require_relative 'cursor'
require_relative 'board'

class Display
  attr_reader :board, :cursor

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], board)
  end

  def render(curr_player)
    system('clear')
    puts "current player: #{curr_player}"

    board.grid.each_with_index do |row, i|
      puts (row.map.with_index do |piece, j|
        piece.to_s.colorize(background: bg_color([i, j], curr_player))
      end.join)
    end

    puts 'check' if board.in_check?(curr_player)
  end

  private

  def valid_move?(pos)
    board[cursor.pos].valid_moves.include?(pos)
  end

  def highlight?(pos, curr_player)
    valid_move?(pos) && board[cursor.pos].color == curr_player
  end

  def bg_color(pos, curr_player)
    if pos == cursor.pos
      cursor.selected ? :blue : :yellow
    elsif (pos[0] + pos[1]).even?
      highlight?(pos, curr_player) ? :light_red : :magenta
    else
      highlight?(pos, curr_player) ? :light_cyan : :cyan
    end
  end
end
