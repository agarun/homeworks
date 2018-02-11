class QuickSort
  # Quick sort has
  # average case time complexity O(nlogn)
  # worst case O(n**2).

  # Not in-place. Uses O(n) memory
  def self.sort1(array)
    return array if array.length <= 1

    pivot_idx = self.partition(array, 0, array.length)

    left = array[0...pivot_idx]
    right = array[pivot_idx + 1..-1]

    self.sort1(left) + [array[pivot_idx]] + self.sort1(right)
  end

  # In-place, Pivot is 1st element
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return if length <= 1

    pivot_idx = self.partition(array, start, length, &prc)

    self.sort2!(array, start, pivot_idx - start, &prc)
    self.sort2!(array, pivot_idx + 1, length - pivot_idx - 1, &prc)

    array
  end

  def self.partition(array, start, length, &prc)
    prc ||= proc { |el1, el2| el1 <=> el2 }

    pivot_idx = start
    divider = start + 1

    (start + 1...start + length).each do |idx|
      # if we find an el lower than the pivot, we swap it with the
      # current divider position. increment divider by 1 since everything
      # to the right of the divider should be greater than the pivot
      if prc.call(array[idx], array[pivot_idx]) == -1 # <
        array[idx], array[divider] = array[divider], array[idx]
        divider += 1
      end
    end

    # swap pivot with what is left of the divider between the lower & higher
    array[pivot_idx], array[divider - 1] = array[divider - 1], array[pivot_idx]

    # return the location of the pivot after swapping
    divider - 1
  end
end

test_sort1_array = [2, 9, 1, 6, 7, 2, 5]
p QuickSort.sort1([2, 9, 1, 6, 7, 2, 5]) == test_sort1_array.sort
