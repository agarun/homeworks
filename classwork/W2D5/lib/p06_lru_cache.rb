require_relative 'p05_hash_map'
require_relative 'p04_linked_list'
require "byebug"

class LRUCache
  attr_reader :count
  def initialize(max, prc = Proc.new { |x| x**2 })
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      node = @map.get(key)
      update_node!(node)
    elsif count < @max
      val = calc!(key)
      @store.append(key, val)
      @map.set(key, @store.last)
    else
      val = calc!(key)
      eject!
      @store.append(key,val)
      @map.set(key, @store.last)
    end

    val
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    @prc.call(key)
  end

  def update_node!(node)
    node.remove
    @store.append(node.key, node.val)
    @map.set(node.key, @store.last)
    node.val
  end

  def eject!
    @map.delete(@store.first.key)
    @store.remove(@store.first.key)
  end
end
