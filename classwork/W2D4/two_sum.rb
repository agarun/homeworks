# O(n^2) time
# O(1) space
def bad_two_sum?(array, target_sum)
  array.each_with_index do |num1, i|
    array[i + 1..-1].each do |num2|
      return true if num1 + num2 == target_sum
    end
  end

  false
end

arr = [0, 1, 5, 7]
p bad_two_sum?(arr, 6) # => should be true
p bad_two_sum?(arr, 10) # => should be false

# O(nlogn) time
# e.g. if it's quicksort, it's n^2 worst case
# e.g. if it's merge sort, it's nlogn worst case
# O(n) space
def okay_two_sum?(array, target_sum)
  sorted = array.sort

  array.each_with_index do |el, idx|
    sorted_without_el = sorted[0...idx] + sorted[idx + 1..-1]
    return true if bsearch(sorted_without_el, target_sum - el)
  end

  false
end

def bsearch(array, target_sum)
  return nil if array.empty?

  mid = array.length / 2

  left = array.take(mid)
  right = array.drop(mid + 1)

  case array[mid] <=> target_sum
  when 0
    mid
  when -1
    result = bsearch(right, target_sum)
    result.nil? ? nil : mid + 1 + result
  when 1
    bsearch(left, target_sum)
  end
end

# instead of binary search, we could use 2 indices (low and high)
# and adjust low and high (+= 1 or -= 1 respectively) until the target_sum is found
# OR low == high

arr = [0, 1, 5, 7]
p okay_two_sum?(arr, 6) # => should be true
p okay_two_sum?(arr, 10) # => should be false

# O(n) time
# O(n) space
def two_sum?(array, target_sum)
  complements = {}

  array.each do |el|
    complement = target_sum - el

    if complements[complement]
      return true
    else
      hsh[el] = true # adjust to index if needing to return indices
    end
  end

  false
end

arr = [0, 1, 5, 7]
p okay_two_sum?(arr, 6) # => should be true
p okay_two_sum?(arr, 10) # => should be false

# TODO: redo 4 sum
# e.g. https://github.com/agarun/algorithms/blob/master/leetcode/Leetcode%2018.%20Four%20Sum.rb
