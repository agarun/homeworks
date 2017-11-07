class Board
  ATTACKED = :x

  NUM_STARTING_SHIPS = 5

  SCREEN_MARKS = {
    a: "A", # aircraft
    b: "B", # battleship
    m: "M", # mariner
    d: "D", # destroyer
    p: "P", # patrol boat
    s: "S", # regular ship
    x: "X"  # a hit!
  }

  attr_reader :grid

  def self.default_grid(n = 10)
    Array.new(n) { Array.new(n) }
  end

  def initialize(grid = self.class.default_grid)
    @grid = grid
  end

  def populate_grid(num_starting_ships = NUM_STARTING_SHIPS)
    place_random_ship until count == num_starting_ships
    puts "\nThe computer's grid was filled with #{num_starting_ships} battleships."
  end

  def place_random_ship
    if full?
      raise "Board is full, can't place any more ships!"
    else
      self[random_position] = :s
    end
  end

  def random_position
    [rand(grid.size), rand(grid.size)]
  end

  def count
    grid.flatten.count { |position| position == :s }
  end

  def empty?(position = nil)
    # if the position isn't given, board is empty if game is over!
    position ? self[position].nil? : won?
  end

  def full?
    # count == grid.size * grid.first.size
    grid.flatten.count(nil).zero?
  end

  def won?
    count.zero?
  end

  def [](position)
    row, col = position
    grid[row][col]
  end

  def []=(position, mark)
    row, col = position
    grid[row][col] = mark
  end

  def display
    # system("clear") || system("cls")

    # column headers
    print ("\n") + ("\s" * 9)
    (0...grid.size).each { |col_number| print "#{col_number}\s\s\s\s\s" }
    print ("\n") + ("\s" * 9) + ("-" * 59) + ("\n")

    # row headers
    SCREEN_MARKS.default = "."
    grid.each_with_index do |row, row_number|
      print ("\s" * 5) + "#{row_number}\s\s|"
      print row.map { |el| SCREEN_MARKS[el] }.join("\s" * 5)
      print ("\n") + ("\s" * 8) + ("|\n")
    end
  end
end
