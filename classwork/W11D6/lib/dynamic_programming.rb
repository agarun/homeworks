class DynamicProgramming
  def initialize
    @blair_cache = { 1 => 1, 2 => 2 }
  end

  # b1 = 1
  # b2 = 2
  # bk = sum of the prev 2 b nums + (k-1)th odd number
  #   e.g. b3 = b2 + b1 + 2nd odd num
  #           = 1 + 2 + 3 = 6
  # `blair_nums` returns the nth Blair number
  
  # top-down
  def blair_nums(n)
    return @blair_cache[n] if @blair_cache[n]

    n_minus_1_th_number = 2 * n - 3
    @blair_cache[n] =
      blair_nums(n - 2) +
      blair_nums(n - 1) +
      n_minus_1_th_number
  end

  # bottom-up
  def blair_nums(n)
    blair_cache = { 1 => 1, 2 => 2 }
    (3..n).each do |b|
      blair_cache[b] = blair_cache[b - 1] + blair_cache[b - 2] + (2 * b - 3)
    end

    blair_cache[n]
  end

  def frog_hops_bottom_up(n)

  end

  def frog_cache_builder(n)

  end

  def frog_hops_top_down(n)

  end

  def frog_hops_top_down_helper(n)

  end

  def super_frog_hops(n, k)

  end

  def knapsack(weights, values, capacity)

  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)

  end

  def maze_solver(maze, start_pos, end_pos)
  end
end
