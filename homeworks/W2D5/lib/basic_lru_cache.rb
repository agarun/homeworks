class LRUCache
  attr_reader :max_cache_size

  def initialize(max_cache_size)
    @cache = []
    @max_cache_size = max_cache_size
  end

  def count
    @cache.size
  end

  # add element to reserved slot if available, else allocate slots and add element
  def add(element)
    if cache.include?(element)
      cache.delete(element)
    elsif cache.size >= max_cache_size
      cache.shift
    end

    cache << element
    nil
  end

  def show
    p @cache
    nil
  end

  private

  attr_reader :cache
end

# johnny_cache = LRUCache.new(4)
#
# johnny_cache.add("I walk the line")
# johnny_cache.add(5)
#
# johnny_cache.count # => returns 2
#
# johnny_cache.add([1, 2, 3])
# johnny_cache.add(5)
# johnny_cache.add(-5)
# johnny_cache.add({ a: 1, b: 2, c: 3 })
# johnny_cache.add([1, 2, 3, 4])
# johnny_cache.add("I walk the line")
# johnny_cache.add(:ring_of_fire)
# johnny_cache.add("I walk the line")
# johnny_cache.add({ a: 1, b: 2, c: 3 })
#
# johnny_cache.show
# => prints [[1, 2, 3, 4], :ring_of_fire, "I walk the line", {:a=>1, :b=>2, :c=>3}]
