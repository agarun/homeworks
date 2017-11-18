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
    resize! if count >= num_buckets

    current_bucket = bucket(key)
    if include?(key)
      current_bucket.update(key, val)
    else
      current_bucket.append(key, val)
      @count += 1
    end
    nil
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    if include?(key)
      bucket(key).remove(key)
      @count -= 1
    else
      nil
    end
  end

  def each(&prc)
    @store.each do |bucket|
      bucket.each do |node|
        prc.call(node.key, node.val)
      end
    end

    self
  end

  # uncomment when you have Enumerable included
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
    new_size = 2 * num_buckets
    new_store = Array.new(new_size) { LinkedList.new }

    each do |key, val|
      new_store[key.hash % new_size].append(key, val)
    end

    @store = new_store
    nil
  end

  def bucket(key)
    @store[key.hash % num_buckets]
  end
end
