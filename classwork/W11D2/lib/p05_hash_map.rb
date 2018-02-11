require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable

  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    resize! if @count == num_buckets

    if include?(key)
      bucket(key).update(key, val)
    else
      bucket(key).append(key, val)
      @count += 1
    end

    val
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    if include?(key)
      bucket(key).remove(key)
      @count -= 1
    end
  end

  def each(&prc)
    @store.each do |bucket|
      bucket.each do |node_in_list|
        prc.call(node_in_list.key, node_in_list.val)
      end
    end

    self
  end

  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    double_buckets = 2 * num_buckets
    new_store = Array.new(double_buckets) { LinkedList.new }

    @store.each do |bucket|
      bucket.each do |node|
        key = node.key
        val = node.val
        # rehash with `double_buckets`
        new_store[key.hash % double_buckets].append(key, val)
      end
    end

    @store = new_store
  end

  # returns a linked list
  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    idx = key.hash % num_buckets
    @store[idx]
  end
end
