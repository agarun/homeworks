require_relative "../polytreenode/lib/00_tree_node.rb"
require "set"

class KnightPathFinder
  KNIGHT_MOVES = [
    [-2, -1],
    [-1, -2],
    [2, -1],
    [1, -2],
    [2, 1],
    [1, 2],
    [-2, 1],
    [-1, 2]
  ]

  # gets the 8 possible knight moves at the current position
  def self.total_moves(position)
    pos_x , pos_y = position
    KNIGHT_MOVES.map do |move|
      x, y = move
      [pos_x + x, pos_y + y]
    end
  end

  def self.valid_moves(position)
    KnightPathFinder.total_moves(position).select do |pos|
      KnightPathFinder.within_bounds?(pos)
    end
  end

  def self.within_bounds?(position)
    position.all? { |pos| pos.between?(0, 7)}
  end

  attr_reader :visited_positions

  def initialize(start_position)
    @start_tile = PolyTreeNode.new(start_position)
    @visited_positions = Set.new([start_position])
    @move_tree = build_move_tree
  end

  def new_move_positions(position)
    new_positions = self
      .class
      .valid_moves(position)
      .reject { |pos| @visited_positions.include?(pos) }

    # add the remaining new level of positions to @visited_positions
    # & return these new positions
    @visited_positions.merge(new_positions)
    new_positions
  end

  def build_move_tree
    queue = [@start_tile]
    until queue.empty?
      current_tile = queue.shift

      # get the new positions from the current_tile in the queue
      # new_move_positions returns an array of positions from the current tile
      all_positions = new_move_positions(current_tile.value)

      # each position will be a child to the current_tile
      all_positions.each do |position|
        child_tile = PolyTreeNode.new(position)
        current_tile.add_child(child_tile)
        queue.push(child_tile)
      end
    end

    @start_tile
  end

  def find_path(target_position)
    target_tile = find_path_dfs(@start_tile, target_position)
    trace_path_back(target_tile)
  end

  def find_path_dfs(start_tile, target_position)
    if start_tile.value == target_position
      return start_tile
    else
      start_tile.children.each do |child|
        search_result = find_path_dfs(child, target_position)
        return search_result if !search_result.nil?
      end
    end

    nil
  end

  def trace_path_back(target_tile)
    current_tile = target_tile

    path_positions = []

    # keeps looking at parent adding to the array until the parent is nil (root)
    until current_tile.nil?
      path_positions << current_tile.value
      current_tile = current_tile.parent
    end

    path_positions.reverse
  end
end

knf = KnightPathFinder.new([0, 0])
p knf.find_path([2, 1]) # + alt solution (bfs) => [[0, 0], [2, 1]]
p knf.find_path([3, 3]) # + alt solution (bfs) => [[0, 0], [2, 1], [3, 3]]
p knf.find_path([7, 6]) # + alt solution (bfs) => [[0, 0], [1, 2], [2, 4], [3, 6], [5, 5], [7, 6]]
p knf.find_path([6, 2]) # + alt solution (bfs) => [[0, 0], [1, 2], [2, 0], [4, 1], [6, 2]]
