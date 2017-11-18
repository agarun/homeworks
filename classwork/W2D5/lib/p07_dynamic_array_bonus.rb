# StaticArray mimics a C array.
class StaticArray
  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    @store[i]
  end

  def []=(i, val)
    validate!(i)
    @store[i] = val
  end

  def length
    @store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, @store.length - 1)
  end
end

class DynamicArray
  include Enumerable

  attr_reader :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
    @start = 0 # start idx, which can be affected by changing the array
  end

  def [](i)
    if i >= @count
      nil
    elsif i < 0
      i < -@count ? nil : (self[@count + i])
    else
      @store[(@start + i) % capacity]
    end
  end

  def []=(i, val)
    if i >= @count
      (i - @count).times { push(nil) } # to be able to access the correct idx, fill nils
    elsif i < 0
      return nil if i < -(@count)
      return self[@count + i] = val
    end

    if i == @count
      resize! if capacity == @count
      @count += 1
    end

    @store[(@start + i) % capacity] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
    any? { |el| el == val }
  end

  def push(val)
    resize! if capacity == @count

    @store[(@start + @count) % capacity] = val
    @count += 1
    self
  end

  def unshift(val)
    resize! if capacity == @count

    @start = (@start - 1) % capacity
    @store[@start] = val
    @count += 1
    self
  end

  def pop
    return nil if @count.zero?

    popped = @store[(@start + @count - 1) % capacity]
    @count -= 1
    popped
  end

  def shift
    return nil if @count.zero?
    @count -= 1

    shifted = @store[@start]
    @start = (@start + 1) % capacity
    shifted
  end

  def first
    return nil if @count.zero?
    @store[@start]
  end

  def last
    return nil if @count.zero?
    @store[(@start + @count - 1) % capacity]
  end

  def each(&prc)
    @count.times { |idx| prc.call(self[idx]) }
    self
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    return false unless self.length == other.length

    each_with_index { |el, idx| return false unless el == other[idx] }
    true
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    new_store = StaticArray.new(capacity * 2)
    each_with_index { |el, idx| new_store[idx] = el }

    @store = new_store
    @start = 0
  end
end
