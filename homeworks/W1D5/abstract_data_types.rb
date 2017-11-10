class Stack
  def initialize
    @stack = []
  end

  def add(element)
    @stack.push(element)
  end

  def remove
    @stack.pop
  end

  def show # copy
    @stack.dup
  end
end

p "stack: LIFO - last in, first out"
stack = Stack.new
stack.add(5)
stack.add(8)
stack.add(2)
stack.add(1)
p stack.show == [5, 8, 2, 1]
p stack.remove == 1
p stack.show == [5, 8, 2]
stack.add(19)
p stack.show == [5, 8, 2, 19]

# alternatives
# class Stack
#   def add(element) # push
#     @stack += [element]
#   end
#
#   def remove # pop
#     last_element = @stack.last
#     @stack = @stack[0..-2]
#     last_element
#   end
# end

class Queue
  def initialize
    @queue = []
  end

  def enqueue(element)
    @queue.push(element)
  end

  def dequeue
    @queue.shift
  end

  def show
    @queue.dup
  end
end

p "queue: FIFO - first in, first out"
queue = Queue.new
queue.enqueue(5)
queue.enqueue(8)
queue.enqueue(2)
queue.enqueue(1)
p queue.show == [5, 8, 2, 1]
p queue.dequeue == 5
p queue.show == [8, 2, 1]
queue.enqueue(19)
p queue.show == [8, 2, 1, 19]

# alternatives
# class Queue
#   def enqueue(element)
#     @queue += [element]
#   end
#
#   def dequeue
#     first_element = @queue.first
#     @queue = @queue[1..-1]
#     first_element
#   end
# end

class Map
  def initialize
    @map = []
  end

  def assign(key, value)
    if @map.any? { |pair| pair.first == key }
      prev_pair_idx = @map.index { |pair| pair.first == key }
      @map[prev_pair_idx] = [key, value]
    else
      @map << [key, value]
    end
  end

  def lookup(key)
    @map.find { |pair| pair.first == key }.last
  end

  def remove(key)
    deleted = show - @map.reject! { |pair| pair.first == key }
    deleted.last.last unless deleted.empty? # return value from deleted pair
  end

  def show
    deep_dupe(@map)
  end

  def deep_dupe(array)
    array.map { |element| element.is_a?(Array) ? deep_dupe(element) : element }
  end
end

p "map"
map = Map.new
map.assign(:a, 1)
map.assign(:b, 2)
p map.lookup(:a) == 1
map.assign(:c, 3)
p map.show == [[:a, 1], [:b, 2], [:c, 3]]
p map.remove(:b) == 2
p map.show == [[:a, 1], [:c, 3]]
map.assign(:c, 5)
p map.show == [[:a, 1], [:c, 5]]

# notes & related problems:
## implementing stack with queue (leetcode 225) https://github.com/agarun/algorithms/blob/master/leetcode/Leetcode%20225.%20Implement%20Stack%20using%20Queues.rb
## implementing queue with stack (leetcode 232) https://github.com/agarun/algorithms/blob/master/leetcode/Leetcode%20232.%20Implement%20Queue%20using%20Stacks.rb
