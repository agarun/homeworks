def kth_largest(tree_node, k)
  ordered_tree = in_order_traversal(tree_node)
  ordered_tree[k * -1]
end

def in_order_traversal(tree_node = @root, ordered_tree = [])
  return unless tree_node

  in_order_traversal(tree_node.left, ordered_tree)
  ordered_tree << tree_node
  in_order_traversal(tree_node.right, ordered_tree)

  ordered_tree
end
