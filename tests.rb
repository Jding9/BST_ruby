require 'pry'
load 'node.rb'
load 'binarysearchtree.rb'

#binary_tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
binary_tree = Tree.new([1, 5, 10, 15, 16, 25])
binary_tree.pretty_print
binary_tree.insert(35)
binary_tree.pretty_print
binary_tree.delete(35)
binary_tree.pretty_print
binary_tree.find(5)
p binary_tree.level_order
p binary_tree.inorder
p binary_tree.preorder
p binary_tree.postorder
p binary_tree.height
p binary_tree.depth(binary_tree.root.left.left)
p binary_tree.balanced?
p binary_tree.rebalance