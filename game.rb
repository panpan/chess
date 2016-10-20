require_relative 'display'

class Game
  attr_reader :board, :display, :curr_player

  def initialize
    @board = Board.new(true)
    @display = Display.new(board)
    @curr_player = :white
  end

  def play!
    until board.checkmate?(curr_player)
      begin
        start_pos, end_pos = get_move
        board.move(curr_player, start_pos, end_pos)
        swap_turn!
      rescue StandardError => e
        puts e.message
        sleep(1)
      end
    end

    display.render(curr_player)
    puts 'checkmate!'
    nil
  end

  private
  def get_move
    start_pos, end_pos = nil, nil

    until start_pos
      display.render(curr_player)
      start_pos = display.cursor.get_input
    end

    until end_pos
      display.render(curr_player)
      end_pos = display.cursor.get_input
    end

    [start_pos, end_pos]
  end

  def swap_turn!
    @curr_player = curr_player == :white ? :black : :white
    nil
  end
end

if __FILE__ == $PROGRAM_NAME
  Game.new.play!
end
