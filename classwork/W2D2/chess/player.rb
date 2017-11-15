class HumanPlayer
  attr_reader :name, :color, :display

  def initialize(name, color, display)
    @name = name
    @color = color
    @display = display
  end

  def take_turn
    movesets = []


    until movesets.size == 2
      display.render(color)
      puts("#{name}'s turn (#{color})!")
      choice = display.cursor.get_input
      movesets << choice if choice
      if movesets.size == 1 && display.board[movesets.first].color != color
        raise ArgumentError.new("Pick your own piece!")
      end
    end

    movesets
  end
end
