class Board
  STORE_CUPS = [6, 13] # [player1 store cup index, player2 store cup index]

  attr_accessor :cups

  def initialize(name1, name2)
    @name1 = name1
    @name2 = name2
    @cups = place_stones(Array.new(14) { [] })
  end

  def place_stones(array)
    array.each_with_index do |cup, idx|
      next if STORE_CUPS.include?(idx)
      4.times { cup << :stone }
    end
  end

  def valid_move?(start_pos)
    if start_pos.between?(0, 12) && !cups[start_pos].empty?
      true
    else
      raise "Invalid starting cup"
    end
  end

  def make_move(start_pos, current_player_name)
    stones, @cups[start_pos] = @cups[start_pos], []

    idx = start_pos + 1
    until stones.empty?
      # if current player visits *opponent* player's store, don't add a stone
      unless (STORE_CUPS.last == idx && current_player_name == @name1) ||
             (STORE_CUPS.first == idx && current_player_name == @name2)
        @cups[idx] << stones.pop
      end

      idx = (idx + 1) % cups.size
    end

    render
    next_turn((idx - 1) % cups.size, current_player_name)
  end

  def next_turn(ending_cup_idx, current_player_name)
    # if the player ends by dropping into their own point store, return :prompt
    # elsif the player ends by dropping into an *empty* cup, return :switch
    # else the player ends in a cup that had stones, return `ending_cup_idx` to start next turn
    if STORE_CUPS.include?(ending_cup_idx) # player can only end on own store
      :prompt
    elsif cups[ending_cup_idx].size == 1
      :switch
    else
      ending_cup_idx
    end
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups[0..5].map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    top_empty? || bottom_empty?
  end

  def top_empty?
    @cups[0..5].all?(&:empty?)
  end

  def bottom_empty?
    @cups[7..12].all?(&:empty?)
  end

  def winner
    case @cups[STORE_CUPS.first] <=> @cups[STORE_CUPS.last]
    when 1
      @name1
    when -1
      @name2
    when 0
      :draw
    end
  end
end
