require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @capacity = 8
    @store = StaticArray.new(@capacity)
    @length = 0 # num items in array
    @start_idx = 0
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[(start_idx + index) % capacity]
  end

  # O(1)
  def []=(index, value)
    check_index(index)
    @store[(start_idx + index) % capacity] = value
  end

  # O(1)
  def pop
    raise "index out of bounds" if @length.zero?

    last_idx = length - 1
    last_element = self[last_idx]
    self[last_idx] = nil
    @length -= 1

    last_element
  end

  # O(1) amortized
  def push(value)
    resize! if length == capacity

    @length += 1
    self[length - 1] = value
  end

  # O(1)
  def shift
    raise "index out of bounds" if @length.zero?

    first_element = self[0]
    self[0] = nil
    @start_idx = (start_idx + 1) % capacity
    @length -= 1

    first_element
  end

  # O(1) amortized
  def unshift(value)
    resize! if length == capacity

    @start_idx = (start_idx - 1) % capacity
    @length += 1

    self[0] = value
  end

  protected

  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    raise "index out of bounds" if index >= @length
  end

  def resize!
    new_capacity = 2 * capacity
    new_store = StaticArray.new(@capacity)

    (0...length).each do |i|
      new_store[i] = self[i]
    end

    @capacity = new_capacity
    @store = new_store
    @start_idx = 0
  end
end
