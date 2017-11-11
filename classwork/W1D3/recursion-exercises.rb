def range(low, high)
  return [] if high < low
  return [low] if high - 1 == low

  [low] + range(low + 1, high)
end

p "range tests"
puts range(1, 5) == [1, 2, 3, 4]
puts range(8, 9) == [8]

# recursion 1
def exponent_v1(base, exponent)
  return 1 if exponent.zero?

  base * exponent_v1(base, exponent - 1)
end

p "exponent version 1 tests"
puts exponent_v1(1, 0) == 1**0
puts exponent_v1(2, 4) == 2**4
puts exponent_v1(3, 17) == 3**17
puts exponent_v1(62, 4) == 62**4

# recursion 2
def exponent_v2(base, exponent)
  case
  when exponent == 0
    1
  when exponent == 1
    base
  else
    half = exponent_v2(base, exponent / 2)

    exponent.even? ? half * half : base * half * half
  end
end

p "exponent version 2 tests"
puts exponent_v2(1, 0) == 1**0
puts exponent_v2(2, 6) == 2**6
puts exponent_v2(3, 17) == 3**17
puts exponent_v2(62, 4) == 62**4

class Array
  def deep_dup
    duped_arr = []

    self.each do |el|
      if el.is_a?(Array)
        duped_arr << el.deep_dup
      else
        duped_arr << el
      end
    end

    duped_arr
  end

  def deep_dup_short
    reduce([]) { |duped, el| duped << (el.is_a?(Array) ? el.deep_dup_short : el) }
  end
end

p "deep_dup tests"
robot_parts1 = [
  ["nuts", "bolts", "washers"],
  ["capacitors", "resistors", "inductors"]
]

robot_parts_copy1 = robot_parts1.dup
robot_parts_copy1[1] << "LEDs"
p robot_parts1[1] == ["capacitors", "resistors", "inductors", "LEDs"]

robot_parts2 = [
  ["nuts", "bolts", "washers"],
  ["capacitors", "resistors", "inductors"]
]

robot_parts_copy2 = robot_parts2.deep_dup # .deep_dup_short
robot_parts_copy2[1] << "LEDs"
p robot_parts2[1] == ["capacitors", "resistors", "inductors"]

def fibonacci_recursive(n)
  return [0, 1].take(n) if n <= 2

  remaining_fib = fibonacci_recursive(n - 1)
  second_to_last, last = remaining_fib[-2..-1]
  remaining_fib << second_to_last + last
end

def fibonacci_iterative(n)
  fib_base = [0, 1]

  return fib_base.take(n) if n <= 2

  until fib_base.size == n
    fib_base << fib_base[-2] + fib_base[-1]
  end

  fib_base
end

p "fib tests"
p fibonacci_recursive(5)
p fibonacci_recursive(12)
p fibonacci_iterative(5)
p fibonacci_iterative(12)

def subsets(arr)
  return [[]] if arr.empty?
  tail = arr.pop
  subs = subsets(arr)
  subs + subs.map { |sub| sub + [tail] }
end

p "subset tests"
p subsets([]) == [[]]
p subsets([1]) == [[], [1]]
p subsets([1, 2]) == [[], [1], [2], [1, 2]]
p subsets([1, 2, 3]) == [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]

def permutations(arr)
  return [arr] if arr.length <= 1
  last = arr[-1]
  prev_perms = permutations(arr[0...-1])

  perms = []
  prev_perms.each do |perm|
    perms += add_number_at_every_index(perm, last)
  end
  perms.sort
end

def add_number_at_every_index(array, number)
  perms = []

  (array.length + 1).times do |i|
    perms << array[0...i] + [number] + array[i..-1]
  end

  perms
end

p "perms tests"
p permutations([1, 2]) == [1, 2].permutation.to_a
p permutations([1, 2, 3]) == [1, 2, 3].permutation.to_a
p permutations([1, 2, 3, 4, 5]) == [1, 2, 3, 4, 5].permutation.to_a

def bsearch(arr, target)
  mid = arr.size / 2
  mid_val = arr[mid]

  return mid if target == arr[mid]
  return nil if arr.empty?

  if mid_val < target
    search_result = bsearch(arr[mid + 1..-1], target)
    search_result ? mid + 1 + search_result : nil
  else
    bsearch(arr[0...mid], target)
  end
end

p "binary_search tests"
p bsearch([1, 2, 3], 1) == 0
p bsearch([2, 3, 4, 5], 3) == 1
p bsearch([2, 4, 6, 8, 10], 6) == 2
p bsearch([1, 3, 4, 5, 9], 5) == 3
p bsearch([1, 2, 3, 4, 5, 6], 6) == 5
p bsearch([1, 2, 3, 4, 5, 6], 0) == nil
p bsearch([1, 2, 3, 4, 5, 7], 6) == nil

def merge_sort(array)
  return array if array.size <= 1
  mid_idx = array.length / 2

  left = array[0...mid_idx]
  right = array[mid_idx..-1] # !

  merge(merge_sort(left), merge_sort(right))
end

def merge(left, right)
  merged = []

  until left.empty? || right.empty?
    if left.first < right.first
      merged << left.shift
    else
      merged << right.shift
    end
  end

  merged + left + right
end

p "merge sort tests"
p merge_sort((1..1000).to_a.shuffle) == (1..1000).to_a

# greedy
# def make_change(target, coins = [25, 10, 5, 1])
#   change = []
#
#   first_coin = coins.first
#   count = amount / first_coin
#   count.times { change << coin }
#   amount -= count * coin
#
#   if amount > 0
#     change += make_change(amount, coins.drop(1)) # use the other coins
#   end
#
#   change
# end

# assuming coins are in reverse sorted order
def make_change(target_amount, coins = [25, 10, 5, 1])
  return [] if target_amount == 0 # no money to make change for

  best_change = nil

  coins.each_with_index do |coin, index|
    next if coin > target_amount

    # use the current coin to calculate change -> explore every possible result
    # check the bigger coins first (so we iterate from biggest to smallest)
    # this is done with `coins.drop(index)` to avoid getting a result that is
    # simply a permutation of an earlier result with a smaller value first
    ## e.g. avoid having [10, 1, 1, 1, 1] as a result and [1, 10, 1, 1]
    change_for_remainder = make_change(target_amount - coin, coins.drop(index))

    # in case target_amount *can't* be made with coins
    # (e.g. target: 5, coins AFTER dropping: 2 --> errors with `nil` on line 237)
    next if change_for_remainder.nil?

    change = [coin] + change_for_remainder # a change sequence for target

    # use the result that uses the *least* coins to make the `target_amount`
    if best_change.nil? || change.size < best_change.size
      best_change = change
    end
  end

  best_change
end

p "make_change tests"

# assume coins in descending order
p make_change(14, [10, 7, 1]) == [7, 7]

# explore each option with each coin -> best of:
# why? because [7, 7] is preferable over [10, 1, 1, 1, 1]
# [10] + make_change(4)
# [7] + make_change(7)
# [1] + make_change(13)

p make_change(99, [25, 10, 5, 1]) == [25, 25, 25, 10, 10, 1, 1, 1, 1]

p make_change(5, [2]).nil?
