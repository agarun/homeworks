require_relative "bst_node"
# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.

class BinarySearchTree
  attr_reader :root

  def initialize
    @root = nil
  end

  def insert(value)
    if root.nil?
      @root = BSTNode.new(value)
    else
      add_to_subtree(value)
    end
  end

  def find(value, tree_node = @root)
    if tree_node.nil?
      nil
    elsif value == tree_node.value
      tree_node
    # TODO: refactor...
    elsif value <= tree_node.value
      find(value, tree_node.left)
    else
      find(value, tree_node.right)
    end
  end

  # TODO refactor...
  def delete(value)
    tree_node = find(value)

    if tree_node.nil? # node wasn't found in the BST
      nil
    elsif tree_node.left.nil? && tree_node.right.nil?
      remove_node(tree_node)
    elsif tree_node.left && tree_node.right.nil?
      promote_child_to_parent(tree_node, tree_node.left)
    elsif tree_node.left.nil? && tree_node.right
      promote_child_to_parent(tree_node, tree_node.right)
    else # two children
      max_node = maximum(tree_node.left)
      promote_child_to_parent(tree_node, max_node)

      # in the case that the max node has a child, which must be on the left b/c
      # a right child cannot exist for a max node (or else it'd be our max),
      # attach the children to the old parent of the max node
      promote_child_to_parent(max_node, max_node.left) if max_node.left
    end
  end

  def maximum(tree_node = @root)
    max_node = tree_node
    current_node = tree_node

    # keep going right (larger values) until reaching a dead end
    until current_node.nil?
      max_node = current_node if max_node.value < current_node.value
      current_node = current_node.right
    end

    max_node
  end

  def depth(tree_node = @root)
    return -1 if tree_node.nil? # there were no children
    1 + [depth(tree_node.left), depth(tree_node.right)].max
  end

  def is_balanced?(tree_node = @root)
    return true if tree_node.nil?

    (depth(tree_node.left) - depth(tree_node.right)).abs <= 1 &&
      is_balanced?(tree_node.left) &&
      is_balanced?(tree_node.right)
  end

  # returns an array with the data set in sorted order
  # recursively reaches the bottom of the left subtree and appends all
  # the values it meets on any returns & new recursive calls until
  # reaching the root and repeating with the right subtree
  def in_order_traversal(tree_node = @root, arr = [])
    return unless tree_node

    in_order_traversal(tree_node.left, arr)
    arr << tree_node.value
    in_order_traversal(tree_node.right, arr)

    arr
  end

  private

  def add_to_subtree(value, tree_node = @root)
    if value <= tree_node.value
      add_to_left(value, tree_node)
    else
      add_to_right(value, tree_node)
    end
  end

  def add_to_left(value, tree_node)
    if tree_node.left.nil?
      tree_node.left = BSTNode.new(value)
      tree_node.left.parent = tree_node
    else
      add_to_subtree(value, tree_node.left)
    end
  end

  def add_to_right(value, tree_node)
    if tree_node.right.nil?
      tree_node.right = BSTNode.new(value)
      tree_node.right.parent = tree_node
    else
      add_to_subtree(value, tree_node.right)
    end
  end

  def remove_node(tree_node)
    parent = tree_node.parent

    if parent.nil?
      # root to nil if the target node is the root
      @root = nil
    elsif tree_node.value <= parent.value
      parent.left = nil
    else
      parent.right = nil
    end
  end

  def promote_child_to_parent(tree_node, child)
    parent = tree_node.parent

    if parent.nil? # removing the root
      @root = child
      @root.left = tree_node.left
      @root.right = tree_node.right
    elsif tree_node.value <= parent.value
      parent.left = child
    else
      parent.right = child
    end
  end
end
