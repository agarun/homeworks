# Given an array, and a window size w, find the
# maximum range (max - min) within a set of w elements.

def windowed_max_range(array, window_size)
  current_max_range = nil
  # consider each window of size w
  # for each window, find the max value & the min value in the window
  # compare max - min to current_max_range, resetting if necessary
  array.each_cons(window_size) do |window|
    range = window.max - window.min
    current_max_range = range if current_max_range.nil? || current_max_range < range
  end

  current_max_range
end

p windowed_max_range([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
p windowed_max_range([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
p windowed_max_range([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
p windowed_max_range([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8

# -------------------------------

# Stack
# push: adds an element to the top of the stack
# pop: removes an element from the top of the stack and returns it

# Queue
# enqueue: adds an element to the back of the queue
# dequeue: removes an element from the front of the queue and returns it

class MyQueue
  def initialize(store = [])
    @store = store
  end

  def enqueue(item)
    @store << item
    item
  end

  def dequeue
    @store.shift
  end

  def peek
    p @store
    nil
  end

  def size
    @store.size
    nil
  end

  def empty?
    @store.empty?
  end

  def peek
    @store.last
  end
end

class MyStack
  def initialize(store = [])
    @store = store
  end

  def push(item)
    @store << item
    item
  end

  def pop
    @store.pop
  end

  def size
    @store.size
    nil
  end

  def empty?
    @store.empty?
  end

  def peek
    @store.last
  end
end

# StackQueue
# implement a queue again but rather than use an Array,
# implement it using our MyStack class under the hood.

class StackQueue
  def initialize
    @in = MyStack.new
    @out = MyStack.new
  end

  # either enq is O(1) & deq is O(n) or the opposite (here enq is O(1) guaranteed)
  def enqueue(element)
    @in << element
  end

  # deq might be amortized constant time if this is NOT the first deq operation
  # in some dequeue succession
  def dequeue
    remove_elements_to_stack if @out.empty?
    @out.pop
  end

  def size
    [@in + @out].size
  end

  def empty?
    @in.empty? && @out.empty?
  end

  private

  def remove_elements_to_stack
    until @in.empty?
      @out << @in.pop
    end
  end
end

# MinMaxStack
# instead of pushing a value, we can push each element as a `max, min, value`
# so that we can always access the max and min in an O(1) operation

class MinMaxStack
  def initialize
    @store = MyStack.new
  end

  # MyStack#peek returns the top element in the stack (FIFO)
  def min
    @store.peek[:min] unless empty?
  end

  def max
    @store.peek[:max] unless empty?
  end

  def peek
    @store.peek[:value] unless empty?
  end

  def pop
    @store.pop[:value] unless empty?
  end

  # "storing metadata"
  def push(value)
    @store.push({
      max: find_max(value),
      min: find_min(value),
      value: value
    })
  end

  def size
    @store.size
  end

  def empty?
    @store.empty?
  end

  private

  def find_max(value)
    empty? ? value : [max, value].max
  end

  def find_min(value)
    empty? ? value : [min, value].min
  end
end

# enqueue, dequeue, max, and min methods,
# all of which run in constant time

class MinMaxStackQueue
  def initialize
    @in = MinMaxStack.new
    @out = MinMaxStack.new
  end

  def dequeue
    remove_elements_to_stack if @out.empty?
    @out.pop # first element of queue
  end

  def enqueue(value)
    @in << (value)
  end

  def empty?
    @in_stack.empty? && @out_stack.empty?
  end

  # avoid comparing `nil` when pushing to `maxes` and `mins`
  def max
    maxes = []

    maxes << @in.max unless @in.empty?
    maxes << @out.max unless @out.empty?

    maxes.max
  end

  def min
    mins = []

    mins << @in.min unless @in.empty?
    mins << @out.min unless @out.empty?

    mins.min
  end

  def size
    [@in + @out].size
  end

  private

  def remove_elements_to_stack
    until @in.empty?
      @out << @in.pop
    end
  end
end
