# Implement a queue with #enqueue and #dequeue, as well as a #max API,
# a method which returns the maximum element still in the queue. This
# is trivial to do by spending O(n) time upon dequeuing.
# Do it in O(1) amortized - Maybe use an auxiliary storage structure

# Use your RingBuffer to achieve optimal shifts! Write any additional
# methods you need.

require_relative 'ring_buffer'

class QueueWithMax
  attr_accessor :store

  def initialize
    @store = RingBuffer.new
    @max_store = RingBuffer.new
  end

  #  enqueuing:
  #    check tail of `max_store`
  #     if tail is greater than the element, insert element after tail
  #     else remove items from the tail until `max_store` is empty OR
  #       until tail is >= to the element
  #  dequeuing:
  #    if an element is the same as the head of @max_store, remove it
  def enqueue(value)
    until @max_store.length.zero? ||
      @max_store[@max_store.length - 1] >= value
      @max_store.pop
    end
    @max_store.push(value)

    @store.push(value)
  end

  def dequeue
    first_element = @store.shift
    @max_store.shift if @max_store[0] == first_element
  end

  # O(n)
  # def max
  #   max = @store[0]
  #   (1...length).each do |i|
  #     max = @store[i] if max < @store[i]
  #   end
  #   max
  # end

  # O(1) amortized max but O(n) worst case enqueue?
  def max
    @max_store[0]
  end

  def length
    @store.length
  end
end
