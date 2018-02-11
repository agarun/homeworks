# sets dont make any promises about insertion order, and they wont store duplicates
# sets have fast retrieval time and can quickly look up presence of values

class MaxIntSet
  def initialize(max)
    @max = max
    @store = Array.new(max)
  end

  def insert(num)
    validate!(num)
    @store[num] = true
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num <= @max && num >= 0
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  # self[num] to make use of the private helper method
  def insert(num)
    self[num] << num
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

# increase the number of buckets as the size of the set increases
# the goal is to have `buckets.length > N` at all times
class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  # O(1) amortized?
  def insert(num)
    resize! if @count == num_buckets

    @count += 1
    self[num] << num
    num
  end

  def remove(num)
    removed_num = self[num].delete(num)

    @count -= 1 if removed_num
    removed_num
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  # O(n) amortized, O(n^2) worst case
  def resize!
    new_store_length = 2 * num_buckets
    new_store = Array.new(new_store_length) { Array.new }

    @store.each do |bucket|
      bucket.each do |int|
        new_store[int % new_store_length] << int
      end
    end

    @store = new_store
  end
end
