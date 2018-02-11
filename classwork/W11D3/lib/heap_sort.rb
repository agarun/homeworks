require_relative "heap"

class Array
  # in-place sort
  def heap_sort!
    binary_max_heap_prc = proc { |el1, el2| -1 * (el1 <=> el2) }

    # up-heap left to right, adding each el at `i` to the heap & adjusting
    # into the tree structure as necessary
    (0...length).each do |i|
      BinaryMinHeap.heapify_up(self, i, self.length, &binary_max_heap_prc) # log n
    end


    (length - 1).downto(1) do |i|
      # swap the root and the last element
      self[0], self[i] = self[i], self[0]

      # down-heap
      BinaryMinHeap.heapify_down(self, 0, i, &binary_max_heap_prc) # log n
    end

    self
  end

  # Time complexity: O(nlogn)
  # Space complexity: O(1) (in-place)
end

# p [6, 4, 5, 7, 8].heap_sort!
