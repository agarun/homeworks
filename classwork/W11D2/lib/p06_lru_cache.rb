require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

# the hash map will point to the node object in our linked list (if it exists)

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map[key]
      node = @map[key]
      # update since we visited it
      update_node!(node)
    else
      # append a node with this key? retrieve val of that new node with prc
      calc!(key)
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key

    val = @prc.call(key)
    new_node = @store.append(key, val)
    @map[key] = new_node

    # get rid of the first item if we exceeded the max size
    eject! if count > @max

    val
  end

  def update_node!(node)
    # move a node to the end of the list

    node.remove
    moved_node = @store.append(node.key, node.val)
    @map[node.key] = moved_node
  end

  def eject!
    target_node = @store.first

    target_node.remove
    @map.delete(target_node.key)
  end
end
