require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  # O(1) amortized
  def insert(key)
    resize! if @count == num_buckets

    @count += 1
    self[key] << key
    key
  end

  # O(1) amortized
  def include?(key)
    self[key].include?(key)
  end

  # O(1) amortized
  def remove(key)
    removed_key = self[key].delete(key)

    @count -= 1 if removed_key
    removed_key
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
    new_store_length = 2 * num_buckets
    new_store = Array.new(new_store_length) { Array.new }

    # could flatten instead of two loops
    @store.each do |bucket|
      bucket.each do |key|
        new_store[key.hash % new_store_length] << key
      end
    end

    @store = new_store
  end
end
