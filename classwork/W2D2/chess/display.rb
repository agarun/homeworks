require "colorize"
require_relative "cursor"
require_relative "board"

class Display

  attr_reader :cursor, :board

  def initialize(board)
    @cursor = Cursor.new([0, 0], board)
    @board = board
  end

  def render(player_color)
    system("clear")

    board.grid.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        if [i, j] == @cursor.cursor_pos
          print cell.to_s.on_yellow
        else
          places = []
          if !board.no_piece?(cursor.cursor_pos) && board[cursor.cursor_pos].color == player_color
            places = board[cursor.cursor_pos].valid_moves
          end

          if places.include?([i, j])
            if (j + i).odd?
              print cell.to_s.on_magenta
            else
              print cell.to_s.on_light_magenta
            end
          else
            if (j + i).odd?
              print cell.to_s.on_white
            else
              print cell.to_s.on_light_white
            end
          end
        end
      end

      puts
    end
  end

  def run

  end
end
