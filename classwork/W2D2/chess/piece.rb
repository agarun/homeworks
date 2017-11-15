require "singleton"
require "colorize"

class Piece

  DIAGONALS = [[-1, 1], [1, -1], [-1, -1], [1, 1]]
  LINES = [[0, 1], [0, -1], [1, 0], [-1, 0]]

  attr_accessor :position, :board
  attr_reader :directions, :color, :unicode, :symbol

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
      temp = position
      dx, dy = dir

      while board.in_bounds?(temp) && (board.no_piece?(temp) || temp == position)
        all_moves << temp
        temp = [temp.first + dx, temp.last + dy]
      end

      all_moves << temp if board.in_bounds?(temp) && opponent?(temp)
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
      temp = [position.first + dx, position.last + dy]
      all_moves << temp if board.in_bounds?(temp) && (board.no_piece?(temp) || opponent?(temp))
    end

    all_moves
  end
end

class Bishop < Piece
  include SlidingPiece

  def initialize(position, board, color)
    super
    @unicode = color == :black ? "\u265D" : "\u2657"
    @symbol = :Bishop
    @directions = DIAGONALS
  end
end

class Rook < Piece
  include SlidingPiece

  def initialize(position, board, color)
    super
    @unicode = color == :black ? "\u265C" : "\u2656"
    @symbol = :Rook
    @directions = LINES
  end
end

class Queen < Piece
  include SlidingPiece

  def initialize(position, board, color)
    super
    @unicode = color == :black ? "\u265B" : "\u2655"
    @symbol = :Queen
    @directions = LINES + DIAGONALS
  end
end

class Knight < Piece
  include SteppingPiece

  def initialize(position, board, color)
    super
    @unicode = color == :black ? "\u265E" : "\u2658"
    @symbol = :Knight
    @directions = [[-2, -1], [-2, 1], [2, -1], [2, 1], [1, -2], [1, 2], [-1, -2], [-1, 2]]
  end
end

class King < Piece
  include SteppingPiece

  def initialize(position, board, color)
    super
    @unicode = color == :black ? "\u265A" : "\u2654"
    @symbol = :King
    @directions = LINES + DIAGONALS
  end
end

class Pawn < Piece
  attr_reader :attacking_direction, :starting_position

  def initialize(position, board, color)
    super
    @unicode = color == :black ? "\u265F" : "\u2659"
    @symbol = :Pawn
    @starting_position = position

    if color == :black
      @directions = [[1,0]]
      @attacking_direction = [[1, 1], [1, -1]]
    else
      @directions = [[-1,0]]
      @attacking_direction = [[-1, 1], [-1, -1]]
    end
  end

  def moves
    all_moves = []
    dx, dy = directions.first
    temp = [position.first + dx, position.last + dy]

    if board.in_bounds?(temp) && board.no_piece?(temp)
      all_moves << temp
      temp = [temp.first + dx, temp.last + dy]

      if @starting_position == position && board.in_bounds?(temp) && board.no_piece?(temp)
        all_moves << temp
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

  def to_a
    nil
  end
end
