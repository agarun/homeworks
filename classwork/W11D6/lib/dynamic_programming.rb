class DynamicProgramming
  def initialize
    @blair_cache = { 1 => 1, 2 => 2 }

    @frog_cache = {
      1 => [[1]],
      2 => [[1, 1], [2]],
      3 => [[1, 1, 1], [1, 2], [2, 1], [3]]
    }

    @super_frog_cache = {
      0 => [[]],
      1 => [[1]]
    }
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

  # a frog can only hop 1, 2, or 3 steps at a time
  # write a function to return the set of ways the frog can
  # get to the top of the stairs. For example, if there are two stairs
  # in the staircase, there are two ways for the frog to get to the top:
  # hop 2 steps, or hop 1 step and then hop 1 step again.
  # For n = 3, there are 4 ways: [1, 1, 1], [1, 2], [2, 1], and [3].

  # Num of hops the frog can hop to the top of n stairs = Sn
  # The frog has 3 choices for its first hop.
  # -> Sn = Sn-1 + Sn-2 + Sn-3 because you want to consider all the ways
  # that the frog could've hopped to previous positions, which must be
  # the last 3 positions

  def frog_hops_bottom_up(n)
    frog_cache = frog_cache_builder(n)
    frog_cache[n]
  end

  def frog_cache_builder(n)
    frog_cache = {
      1 => [[1]],
      2 => [[1, 1], [2]],
      3 => [[1, 1, 1], [1, 2], [2, 1], [3]]
    }

    (4..n).each do |f|
      last = frog_cache[f - 1].map { |ary| ary + [1] }
      second_to_last = frog_cache[f - 2].map { |ary| ary + [2] }
      third_to_last = frog_cache[f - 3].map { |ary| ary + [3] }
      frog_cache[f] = last + second_to_last + third_to_last
    end

    frog_cache
  end

  def frog_hops_top_down(n)
    frog_hops_top_down_helper(n)
  end

  def frog_hops_top_down_helper(n)
    return @frog_cache[n] if @frog_cache[n]

    # TODO: the helper should take in a number 1, 2, or 3, and map over input adding [n]
    last = frog_hops_top_down_helper(n - 1).map { |ary| ary + [1] }
    second_to_last = frog_hops_top_down_helper(n - 2).map { |ary| ary + [2] }
    third_to_last = frog_hops_top_down_helper(n - 3).map { |ary| ary + [3] }

    @frog_cache[n] = last + second_to_last + third_to_last
  end

  # n - num stairs, k - max stairs
  def super_frog_hops(n, k)
    return [[]] if n == 0
    return [[1]] if n == 1

    hops = []
    max_stairs = k > n ? n : k
    (1..max_stairs).each do |i|
      # probably do not want to use `+=` here in Ruby, map over instead?
      hops += super_frog_hops(n - i, max_stairs).map { |ary| ary + [i] }
    end

    hops
  end

  def super_frog_hops(n, k)
    return @super_frog_cache[n] if @super_frog_cache[n]

    hops = []
    max_stairs = k > n ? n : k
    (1..max_stairs).each do |i|
      hops += super_frog_hops(n - i, max_stairs).map { |ary| ary + [i] }
    end

    @super_frog_cache[n] = hops
  end

  def knapsack(weights, values, capacity)

  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)

  end

  def maze_solver(maze, start_pos, end_pos)
  end
end
