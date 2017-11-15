require "singleton"
require "colorize"

class Piece
  DIAGONALS = [[-1, 1], [1, -1], [-1, -1], [1, 1]]
  LINES = [[0, 1], [0, -1], [1, 0], [-1, 0]]

  attr_accessor :position, :board
  attr_reader :directions, :color, :unicode

  def initialize(position, board, color)
    @position = position
    @board = board
    @color = color
  end

  def to_s
    case color
    when :black
      " #{unicode.colorize(:black)} "
    when :white
      " #{unicode.colorize(:black)} "
    else
      " #{unicode} "
    end
  end

  def valid_moves
    moves.reject { |move| move_into_check?(move) }
  end

  def move_into_check?(end_pos)
    temp_board = board.dup
    temp_board.move_piece!(position, end_pos)
    temp_board.in_check?(color)
  end

  def opponent?(position)
    self.board[position].color != self.color
  end
end

module SlidingPiece
  def moves
    all_moves = []

    directions.each do |dir|
      temp_pos = position
      dx, dy = dir

      while board.in_bounds?(temp_pos) && (board.no_piece?(temp_pos) || temp_pos == position)
        all_moves << temp_pos
        temp_pos = [temp_pos.first + dx, temp_pos.last + dy]
      end

      all_moves << temp_pos if board.in_bounds?(temp_pos) && opponent?(temp_pos)
    end
    all_moves.delete(position)

    all_moves
  end
end

module SteppingPiece
  def moves
    all_moves = []

    directions.each do |dir|
      dx, dy = dir
      x, y = position
      temp_pos = [x + dx, y + dy]

      if board.in_bounds?(temp_pos) &&
        (board.no_piece?(temp_pos) || opponent?(temp_pos))
        all_moves << temp_pos
      end
    end

    all_moves
  end
end

class Bishop < Piece
  include SlidingPiece

  def initialize(position, board, color)
    super
    @unicode = color == :black ? "\u265D" : "\u2657"
    @directions = DIAGONALS
  end
end

class Rook < Piece
  include SlidingPiece

  def initialize(position, board, color)
    super
    @unicode = color == :black ? "\u265C" : "\u2656"
    @directions = LINES
  end
end

class Queen < Piece
  include SlidingPiece

  def initialize(position, board, color)
    super
    @unicode = color == :black ? "\u265B" : "\u2655"
    @directions = LINES + DIAGONALS
  end
end

class Knight < Piece
  include SteppingPiece

  def initialize(position, board, color)
    super
    @unicode = color == :black ? "\u265E" : "\u2658"
    @directions = [[-2, -1], [-2, 1], [2, -1], [2, 1], [1, -2], [1, 2], [-1, -2], [-1, 2]]
  end
end

class King < Piece
  include SteppingPiece

  def initialize(position, board, color)
    super
    @unicode = color == :black ? "\u265A" : "\u2654"
    @directions = LINES + DIAGONALS
  end
end

class Pawn < Piece
  attr_reader :attacking_direction, :starting_position

  def initialize(position, board, color)
    super
    @unicode = color == :black ? "\u265F" : "\u2659"
    @starting_position = position

    case color
    when :black
      @directions = [[1,0]]
      @attacking_direction = [[1, 1], [1, -1]]
    when :white
      @directions = [[-1,0]]
      @attacking_direction = [[-1, 1], [-1, -1]]
    end
  end

  def moves
    all_moves = []

    dx, dy = directions.first
    x, y = position
    temp_pos = [x + dx, y + dy]

    if board.in_bounds?(temp_pos) &&
      board.no_piece?(temp_pos)
      all_moves << temp_pos
      temp_pos = [temp_pos.first + dx, temp_pos.last + dy]

      if @starting_position == position &&
        board.in_bounds?(temp_pos) &&
        board.no_piece?(temp_pos)
        all_moves << temp_pos
      end
    end

    @attacking_direction
      .map { |dir| [position.first + dir.first, position.last + dir.last] }
      .each { |dir| all_moves << dir if board.in_bounds?(dir) && self.opponent?(dir) && !board.no_piece?(dir) }

    all_moves
  end
end

class NullPiece < Piece
  include Singleton

  def initialize
    @unicode = " "
  end
end
