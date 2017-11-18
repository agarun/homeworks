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
    # optional but useful, connects previous link to next link
    # and removes self from list.

    self.prev.next = self.next
    self.next.prev = self.prev
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @tail.prev == @head
  end

  # O(n)
  def get(key)
    node_to_find = get_node(key)
    node_to_find.val unless node_to_find.nil?
  end

  def get_node(key)
    each { |node| return node if node.key == key }
    nil
  end

  def include?(key)
    !get_node(key).nil?
  end

  # O(1)
  def append(key, val)
    new_node = Node.new(key, val)

    # new_node's prev points to tail's former previous
    new_node.prev = @tail.prev

    # tail's former previous now points to new_node
    @tail.prev.next = new_node

    # new_node's next now points to the tail
    new_node.next = @tail

    # update the tail's previous
    @tail.prev = new_node
  end

  def update(key, val)
    node_to_update = get_node(key)
    node_to_update.val = val unless node_to_update.nil?
  end

  def remove(key)
    node_to_find = get_node(key)
    return nil if node_to_find.nil?
    node_to_find.remove
  end

  def each(&prc)
    current_node = @head.next

    until current_node.next.nil?
      prc.call(current_node)
      current_node = current_node.next
    end

    self
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
