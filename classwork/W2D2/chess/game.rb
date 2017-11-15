require_relative "board"
require_relative "display"
require_relative "player"

class ChessGame
  attr_reader :board, :display, :player_one, :player_two, :current_player

  def initialize(player_one_name, player_two_name)
    @board = Board.new
    @display = Display.new(board)

    @player_one = HumanPlayer.new(player_one_name, :white, display)
    @player_two = HumanPlayer.new(player_two_name, :black, display)
    @current_player = player_one
  end

  def next_player!
    @current_player = current_player == player_one ? player_two : player_one
  end

  def play
    until board.checkmate?(current_player.color)
      begin
        start_pos, end_pos = current_player.take_turn
        board.move_piece(start_pos, end_pos)
      rescue ArgumentError => e
        display.render(current_player.color)
        puts e.message
        sleep(1.5)
        retry
      end

      next_player!
    end

    end_message
  end

  def end_message
    display.render(current_player.color)
    puts "Checkmate."
  end
end

if $PROGRAM_NAME == __FILE__
  player_one = "Timmy"
  player_two = "A-a-ron"
  ChessGame.new(player_one, player_two).play
end
