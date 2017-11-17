# O(n^2) time
# O(n^2) space
def my_min(list)
  min = list.first

  list[1..-1].each_with_index do |num1, i|
    min = num1 if num1 < min

    list[i..-1].each do |num2|
      min = num2 if num2 < min
    end
  end

  min
end

list = [0, 3, 5, 4, -5, 10, 1, 90]
p my_min(list) # =>  -5

# O(n) time
# O(1) space
def my_min2(list)
  min = list.first

  list[1..-1].each do |num|
    min = num if num < min
  end

  min
end

list = [0, 3, 5, 4, -5, 10, 1, 90]
p my_min2(list)  # =>  -5

# O(n^3) space & time ?
def largest_contiguous_subsum(list)
  sums = []

  (0...list.size).each do |i|
    sums << list[i]

    (i + 1...list.size).each do |j|
      sums << list[i..j].reduce(:+)
    end
  end

  sums.max
end

list = [5, 3, -7]
list2 = [0, 3, 5, 4, -5, 10, 1, 90]
p largest_contiguous_subsum(list) # => 8
p largest_contiguous_subsum(list2) # => 108

# solutions are
# O(n) time
# O(1) space
def largest_contiguous_subsum2(list)
  running_sum = list.first
  max_sum = list.first

  (1...list.size).each do |i|
    running_sum += list[i]

    if running_sum < 0
      running_sum = 0
      max_sum = list[i] if list[i] > max_sum
    elsif max_sum <= running_sum
      max_sum = running_sum
    end
  end

  max_sum
end

def largest_contiguous_subsum3(list)
  largest = list.first
  current = list.first

  list.drop(1).each do |num|
    current = 0 if current < 0
    current += num
    largest = current if current > largest
  end

  largest
end

# @param {Integer[]} nums
# @return {Integer}
def max_sub_array(nums)
  sum = nums.first
  sum_to_here = 0

  nums.each do |num|
    # if num is a max, we reset the sequence. otherwise, it keeps growing
    sum_to_here = [num, sum_to_here + num].max
    # the sum will only update if the growing sequence is a new max.
    sum = [sum, sum_to_here].max
  end

  # the last sequential sum is the greatest contiguous sum
  sum
end


p largest_contiguous_subsum2(list) # => 8
p largest_contiguous_subsum2(list2) # => 108
list3 = [-7, -5, -100, -1, -6, -2]
p largest_contiguous_subsum3(list3)
