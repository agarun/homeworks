require_relative 'heap'

# Given an array and an integer k,
# return the k-largest elements in O(nlogk) time.

# O (nlogn)
# def k_largest_elements(array, k)
  # binary_min_heap_prc = proc { |el1, el2| el1 <=> el2 }
  #
  # (0...array.length).each do |i|
  #   BinaryMinHeap.heapify_up(array, i, array.length, &binary_min_heap_prc)
  # end
  #
  # (array.length - 1).downto(1) do |i|
  #   array[0], array[i] = array[i], array[0]
  #   BinaryMinHeap.heapify_down(array, 0, i, &binary_min_heap_prc)
  # end

  # array.take(k)
# end

# O (nlogk)
def k_largest_elements(array, k)
  # min heap that will have a store of max size k
  binary_min_heap = BinaryMinHeap.new { |el1, el2| el1 <=> el2 }

  array.each do |el|
    binary_min_heap.push(el)
  end

  (array.length - k).times { binary_min_heap.extract }

  binary_min_heap.store
end
