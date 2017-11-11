class PolyTreeNode
  attr_reader :parent, :value, :children

  def initialize(value)
    @value = value
    @children = []
    @parent = nil
  end

  def parent=(parent)
    # notify the child's former parent to remove its link to the child
    if !self.parent.nil?
      child_parent = self.parent
      child_parent.children.delete(self)
    end

    # assign new parent to child
    @parent = parent

    # inform new parent that it has a new child (only if the node is not nil)
    @parent.children << self unless parent.nil?
  end

  def add_child(child)
    # (1) add child to parent node (assign *new* @parent)
    # (2) add child to children list (mutate @children from inside `parent=`)
    child.parent = self
  end

  def remove_child(child)
    raise "Can't remove a non-child node (e.g. root)" if child.parent.nil?
    child.parent = nil
  end

  def dfs(target)
    return self if self.value == target

    self.children.each do |child|
      search_result = child.dfs(target)
      return search_result if !search_result.nil?
    end

    nil
  end

  def bfs(target)
    queue = [self]

    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.value == target

      current_node.children.each do |child|
        queue << child
      end
    end

    nil
  end
end
