load 'node.rb'
load 'binarysearchtree.rb'

# create a binary search tree from an array of numbers
tree = Tree.new(Array.new(15) {rand(1..100)})
tree.pretty_print

# confirm the tree is balanced
p tree.balanced?

# Print out all elements in level, pre, post, and in order
p tree.level_order
p tree.inorder
p tree.preorder
p tree.postorder

# try to unbalance the tree by adding several numbers > 100
tree.insert(110)
tree.insert(120)
tree.insert(130)
tree.insert(140)
tree.pretty_print

# Confirm that the tree is unbalanced by calling `#balanced?
p tree.balanced?

# Balance the tree by calling `#rebalance`
tree.rebalance

# Confirm that the tree is balanced by calling `#balanced?`
p tree.balanced?

# Print out all elements in level, pre, post, and in order
p tree.level_order
p tree.inorder
p tree.preorder
p tree.postorder