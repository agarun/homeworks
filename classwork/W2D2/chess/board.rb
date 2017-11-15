require_relative "piece"

class Board
  attr_accessor :grid

  def dup
    new_board = Board.new

    self.grid.each_with_index do |row, i|
      row.each_with_index do |piece, j|
        if piece.is_a?(NullPiece)
          new_board[[i,j]] = NullPiece.instance
        else
          new_board[[i,j]] = piece.class.new(piece.position, new_board, piece.color)
        end
      end
    end
    new_board
  end

  def initialize()
    @grid = self.make_starting_grid
  end

  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def get_pieces(color)
    @grid.flatten.select{|piece| piece.color == color}
  end

  def []=(pos, val)
    row, col = pos
    grid[row][col] = val
  end

  def in_check?(color)
    if color == :black
      opponent = :white
    else
      opponent = :black
    end

    king = get_pieces(color).find {|piece| piece.is_a?(King)}
    get_pieces(opponent).each do |piece|
      return true if piece.moves.include?(king.position)
    end

    false
  end

  def checkmate?(color)
    get_pieces(color).all? { |piece| piece.valid_moves.empty? }
  end


  def move_piece!(start_pos, end_pos)
      self[start_pos], self[end_pos] = self[end_pos], self[start_pos]
      self[end_pos].position = end_pos
      remove_piece(start_pos) unless no_piece?(start_pos)
  end

  def move_piece(start_pos, end_pos)
    if no_piece?(start_pos)
      raise ArgumentError.new("There is no piece at the start position!")
    elsif !self[start_pos].valid_moves.include?(end_pos)
      raise ArgumentError.new("Invalid ending move for given start position.")
    else
      self[start_pos], self[end_pos] = self[end_pos], self[start_pos]
      self[end_pos].position = end_pos
      remove_piece(start_pos) unless no_piece?(start_pos)
    end
  end

  def remove_piece(pos)
    attacked_piece = self[pos]
    self[pos] = NullPiece.instance
  end

  def no_piece?(pos)
    self[pos].is_a?(NullPiece)
  end

  def in_bounds?(pos)
    pos.all? { |coord| coord.between?(0, 7) }
  end

  protected
  def make_starting_grid
    grid = Array.new(8) { Array.new(8) }

    piece_order = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    (0..7).each do |i|
      (0..7).each do |j|
        if i == 0
          grid[i][j] = piece_order[j].new([i,j], self, :black)
        elsif i == 1
          grid[i][j] = Pawn.new([i,j], self, :black)
        elsif i == 6
          grid[i][j] = Pawn.new([i,j], self, :white)
        elsif i == 7
          grid[i][j] = piece_order[j].new([i,j], self, :white)
        else
          grid[i][j] = NullPiece.instance
        end
      end
    end
    grid
  end
end
