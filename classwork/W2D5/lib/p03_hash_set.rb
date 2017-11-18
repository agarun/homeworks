require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  # O(1)
  def insert(key)
    resize! if count >= num_buckets

    unless include?(key)
      self[key] << key
      @count += 1
    end
  end

  # O(1) amortized
  def include?(key)
    self[key].include?(key)
  end

  # O(1) amortized
  def remove(key)
    if include?(key)
      self[key].delete(key)
      @count -= 1
    end
  end

  private

  def [](num)
    idx = num.hash % num_buckets
    @store[idx]
  end

  def num_buckets
    @store.length
  end

  # O(n) amortized

  def resize!
    new_size = 2*num_buckets
    new_store = Array.new(new_size) {Array.new}

    @store.each do |bucket|
      bucket.each do |el|
        new_store[el.hash % new_size] << el
      end
    end

    @store = new_store
  end
end
