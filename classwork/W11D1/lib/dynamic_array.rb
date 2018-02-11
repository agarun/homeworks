require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @capacity = 8
    @store = StaticArray.new(@capacity)
    @length = 0 # num items in array
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[index]
  end

  # O(1)
  def []=(index, value)
    check_index(index)
    @store[index] = value
  end

  # O(1)
  def pop
    raise "index out of bounds" if @length.zero?

    last_idx = length - 1
    last_element = @store[last_idx]

    @store[last_idx] = nil
    @length -= 1

    last_element
  end

  # O(1) amortized & O(n) worst case because of the possible resize
  def push(value)
    resize! if @length == @capacity

    @store[length] = value
    @length += 1

    value
  end

  # O(n): has to shift over all the elements
  def shift
    raise "index out of bounds" if @length.zero?

    first_element = @store[0]

    (1...length).each do |i|
      @store[i - 1] = @store[i]
    end
    @length -= 1

    first_element
  end

  # O(n): has to shift over all the elements
  def unshift(value)
    resize! if @length == @capacity

    new_store = StaticArray.new(@capacity)
    (0...length).each do |i|
      new_store[i + 1] = @store[i]
    end

    new_store[0] = value
    @store = new_store
    @length += 1

    value
  end

  protected

  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    raise "index out of bounds" if index >= @length
  end

  # O(n): has to copy over all the elements to the new store
  def resize!
    new_capacity = 2 * capacity
    new_store = StaticArray.new(@capacity)

    (0...length).each do |i|
      new_store[i] = @store[i]
    end

    @capacity = new_capacity
    @store = new_store
  end
end
