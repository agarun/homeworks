class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    # swap condition for MinHeap
    @prc = prc || proc { |child, parent| child <=> parent }
    @store = []
  end

  def count
    @store.length
  end

  def extract
    # swap heap root with the last element of the tree
    @store[0], @store[count - 1] = @store[count - 1], @store[0]
    # store the root to return it later
    extracted_el = @store.pop
    # down-heap to restore the heap property & order
    @store = BinaryMinHeap.heapify_down(@store, 0)

    extracted_el
  end

  def peek
    @store.first
  end

  def push(value)
    @store.push(value)
    # up-heap to restore the heap property & order
    @store = BinaryMinHeap.heapify_up(@store, count - 1)
  end

  def self.child_indices(len, parent_idx)
    left_child_idx = 2 * parent_idx + 1
    right_child_idx = 2 * parent_idx + 2
    [left_child_idx, right_child_idx].select { |idx| idx < len }
  end

  def self.parent_index(child_idx)
    raise "root has no parent" if child_idx.zero?
    (child_idx - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= proc { |child, parent| child <=> parent }

    first_child_idx, second_child_idx = BinaryMinHeap.child_indices(len, parent_idx)
    return array if first_child_idx.nil?

    child_idx = first_child_idx
    if second_child_idx &&
      prc.call(array[second_child_idx], array[child_idx]) == -1
      child_idx = second_child_idx
    end

    if prc.call(array[child_idx], array[parent_idx]) == -1
      array[child_idx], array[parent_idx] = array[parent_idx], array[child_idx]
      heapify_down(array, child_idx, len, &prc)
    end

    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= proc { |child, parent| child <=> parent }

    return array if child_idx.zero?
    parent_idx = BinaryMinHeap.parent_index(child_idx)

    if prc.call(array[child_idx], array[parent_idx]) == -1
      array[child_idx], array[parent_idx] = array[parent_idx], array[child_idx]
      heapify_up(array, parent_idx, len, &prc)
    end

    array
  end
end
