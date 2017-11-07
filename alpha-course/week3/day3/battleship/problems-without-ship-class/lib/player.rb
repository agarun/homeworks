class HumanPlayer

  attr_reader :name, :board

  def initialize(name = "Jack", board = Board.new)
    @name = name
    @board = board
  end

  def setup(num_starting_ships = Board::NUM_STARTING_SHIPS)
    until num_starting_ships.zero?
      board.display

      print <<~INSTRUCTIONS

        #{name} can place #{num_starting_ships} more ships on the board.
        Tell me where you'd like to place a ship by entering
        the coordinates in the format: row number, column number
      INSTRUCTIONS

      coordinates = get_play
      board[coordinates] = :s
      num_starting_ships -= 1
    end
  end

  def get_play
    position = []

    until position.size == 2 && within_range?(position)
      print "What's your play? "
      position = gets.chomp.split(",").map(&:to_i)
    end

    position
  end

  def within_range?(position)
    position.all? { |coord| (0..9).cover?(coord) }
  end
end

class ComputerPlayer
  attr_reader :name, :board

  def initialize(name = "Bot Jill", board = Board.new)
    @name = name
    @board = board
  end

  def setup
    board.populate_grid
    p board
  end

  def get_play
    play = board.random_position
    play = board.random_position until valid_play?(play)
    play
  end

  def valid_play?(position)
    board[position] != Board::ATTACKED
  end
end
