require "io/console"

KEYMAP = {
  " " => :space,
  "h" => :left,
  "j" => :down,
  "k" => :up,
  "l" => :right,
  "w" => :up,
  "a" => :left,
  "s" => :down,
  "d" => :right,
  "\t" => :tab,
  "\r" => :return,
  "\n" => :newline,
  "\e" => :escape,
  "\e[A" => :up,
  "\e[B" => :down,
  "\e[C" => :right,
  "\e[D" => :left,
  "\177" => :backspace,
  "\004" => :delete,
  "\u0003" => :ctrl_c,
}

MOVES = {
  left: [0, -1],
  right: [0, 1],
  up: [-1, 0],
  down: [1, 0]
}

class Cursor

  attr_reader :cursor_pos, :board

  def initialize(cursor_pos, board)
    @cursor_pos = cursor_pos
    @board = board
  end

  def get_input
    key = KEYMAP[read_char]
    handle_key(key)
  end

  private

  def read_char
    STDIN.echo = false # stops the console from printing return values

    STDIN.raw! # in raw mode data is given as is to the program
               # sys doesn't preprocess special characters such as control-c

    input = STDIN.getc.chr # STDIN.getc reads a one-character string as a
                           # numeric keycode. chr returns a string of the
                           # character represented by the keycode.

    if input == "\e" then
      # nonblocking (method executes async). reads 3 bytes at most from data stream
      # raises an error if no data is available (rescue)
      input << STDIN.read_nonblock(3) rescue nil
      input << STDIN.read_nonblock(2) rescue nil
    end

    STDIN.echo = true # the console prints return values again
    STDIN.cooked! # the opposite of raw mode

    return input
  end

  def handle_key(key)
    case key
    when :return, :space
      cursor_pos
    when :left, :right, :up, :down
      update_pos(MOVES[key])
    when :ctrl_c
      Process.exit(0)
    end
  end

  def update_pos(diff)
    dx, dy = diff
    x, y = cursor_pos

    temp_cursor_pos = [x + dx, y + dy]
    @cursor_pos = temp_cursor_pos if board.in_bounds?(temp_cursor_pos)

    nil
  end
end
