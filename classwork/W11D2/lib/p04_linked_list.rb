class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous node to next node
    # and removes self from list.

    # consider if the removed node needs to be deallocated

    self.next.prev = self.prev
    self.prev.next = self.next
  end
end

class LinkedList
  include Enumerable

  # head and tail should never be reassigned
  def initialize
    @sentinel_head = Node.new
    @sentinel_tail = Node.new
    @sentinel_head.next = @sentinel_tail
    @sentinel_tail.prev = @sentinel_head
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    @sentinel_head.next
  end

  def last
    @sentinel_tail.prev
  end

  def empty?
    @sentinel_head.next == @sentinel_tail
  end

  def get(key)
    node = get_node(key)
    node.val if node
  end

  def include?(key)
    !!get_node(key)
  end

  def append(key, val)
    new_node = Node.new(key, val)

    new_node.prev = @sentinel_tail.prev
    @sentinel_tail.prev.next = new_node

    new_node.next = @sentinel_tail
    @sentinel_tail.prev = new_node

    new_node
  end

  def update(key, val)
    target_node = get_node(key)
    target_node.val = val if target_node
  end

  def remove(key)
    target_node = get_node(key)
    target_node.remove
  end

  # by doing include Enumerable, the module gives us access to
  # `map`, `each_with_index`, `select`, `any?`
  def each(&prc)
    current_node = @sentinel_head.next

    until current_node == @sentinel_tail
      prc.call(current_node)
      current_node = current_node.next
    end

    self
  end

  def get_node(key)
    each { |node| return node if node.key == key }
    nil
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  end
end
