def kth_largest(tree_node, k)
  arr = in_order_traversal(tree_node)
  arr[k * -1]
end

def in_order_traversal(tree_node = @root, arr = [])
  return unless tree_node

  in_order_traversal(tree_node.left, arr)
  arr << tree_node
  in_order_traversal(tree_node.right, arr)

  arr
end
