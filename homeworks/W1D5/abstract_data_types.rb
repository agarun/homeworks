class Stack
  def initialize
    @stack = []
  end

  def add(element)
    @stack << element
  end

  def remove
    @stack.pop
  end

  def show
    @stack.dup
  end
end

p "stack"
# LIFO - last in, first out
stack = Stack.new
stack.add(5)
stack.add(8)
stack.add(2)
stack.add(1)
p stack.show # => [5, 8, 2, 1]
p stack.remove # => 1
p stack.show # => [5, 8, 2]
stack.add(19)
p stack.show # => [5, 8, 2, 19]

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
    @queue << element
  end

  def dequeue
    @queue.shift
  end

  def show
    @queue.dup
  end
end

p "queue"
# LIFO - first in, first out
queue = Queue.new
queue.enqueue(5)
queue.enqueue(8)
queue.enqueue(2)
queue.enqueue(1)
p queue.show # => [5, 8, 2, 1]
p queue.dequeue # => 5
p queue.show # => [8, 2, 1]
queue.enqueue(19)
p queue.show # => [8, 2, 1, 19]

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
