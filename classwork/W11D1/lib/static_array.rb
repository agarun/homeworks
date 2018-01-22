class StaticArray
  def initialize(length)
    @store = Array.new(length)
  end

  # O(1)
  def [](index)
    @store[index]
  end

  # O(1)
  def []=(index, value)
    @store[index] = value
  end

  protected

  attr_accessor :store
end
