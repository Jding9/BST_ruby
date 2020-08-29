require 'pry'

class Node

    attr_accessor :data, :left, :right

    def initialize
        @data
        @left = nil #this is the left node that it's pointing to
        @right = nil #this is the right node that it's pointing to
    end

end

class Tree

    attr_accessor :array, :sorted_array, :root

    def initialize(array)
        @sorted_array = array.sort.uniq unless array.nil?
        @root = build_tree(@sorted_array)
    end

    def build_tree(arr)

        if arr.length.zero?
            return nil
        elsif arr.length == 1
            new_node = Node.new()
            new_node.data = arr[0]
            return new_node
        else
            mid = arr.length/2 #this will give you the rounded down number (i.e. 5 / 2 = 2)
            # data of new root is the middle of the array
            root = Node.new()
            root.data = arr[mid]
            root.left = build_tree(arr[0..mid-1])
            root.right = build_tree(arr[mid+1..arr.length-1])
            return root
        end
    
    end

    def insert(value, root) # takes in a value and root of a binary search tree and binary tree will be updated with the new value as a leaf node

        new_node = Node.new()
        new_node.data = value

        if root.data < new_node.data
            if root.right.nil?
                root.right = new_node
            else
                insert(value, root.right)
            end
        elsif root.data > new_node.data
            if root.left.nil?
                root.left = new_node
            else
                insert(value, root.left)
            end
        end
        
    end

    def delete(value, root) # your inputs are a value and the binary tree and the output is the updated binary tree with the deleted node

        # finds the inorder successor (basically the minimum value in the node)
        def minValue(node)
            current = node

            until current.left == nil
                current = current.left
            end

            return current
        end

        return root if root.data.nil?
        
        if value < root.data
            root.left = delete(value, root.left)
        elsif value > root.data
            root.right = delete(value, root.right)
        elsif root.left.nil? && root.right.nil?
            root = nil
        elsif root.left.nil?
            root = root.right
        elsif root.right.nil?
            root = root.left
        else
            temp = minValue(root.right)
            root.data = temp.data
            root.right = delete(temp.data, root.right)
        end

        # we return the root here because this will update the actual binary tree. Without this, it doesn't work
        # The next level up, we need to see something returned - i.e. if root.right = delete(value, root.right), we need to have something returned into this
        # compared to above: we don't have a situation where it's variable = insert(value, root) otherwise we'd need to return something there too
        root

    end

    def find(value, root)
        
        return nil if root.data.nil? 

        if root.data == value
            return root
        elsif value > root.data
            find(value, root.right)
        elsif value < root.data
            find(value, root.left)
        end

    end

    def level_order(root)

        node_values = [] #the list of values in level first traversal
        queue = []
        return nil if root.data.nil?
        queue.push(root)

        # while there is 1 discovered node
        while (!queue.empty?)
            current = queue[0]
            node_values.push(current.data)
            queue.push(current.left) if !current.left.nil?
            queue.push(current.right) if !current.right.nil?
            queue.shift
        end
        return node_values
    end

    def inorder(root, arr = [])
        
        return arr if root.nil?

        # question here may be - why do we return arr when root is nil? 
        # the answer is we need to return something when we reach a nil node and it has to be arr because in a way, the arr travels along the entire tree
        # the arr has data pushed into it when we're traversing the tree and so when there's nothing to push, we return arr so it can go up a level with the
        # data that it has recorded 

        # why can't I return [] if root.nil? 
        # well it's because if you do that

        inorder(root.left, arr)
        arr << root.data
        inorder(root.right, arr)

    end


    def pretty_print(node = root, prefix="", is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? "│ " : " "}", false) if node.right
        puts "#{prefix}#{is_left ? "└── " : "┌── "}#{node.data.to_s}"
        pretty_print(node.left, "#{prefix}#{is_left ? " " : "│ "}", true) if node.left
    end

end



# binary_tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
binary_tree = Tree.new([1, 5, 10, 15, 16, 25])
binary_tree.pretty_print
binary_tree.insert(35, binary_tree.root)
binary_tree.pretty_print
binary_tree.delete(35, binary_tree.root)
binary_tree.pretty_print
binary_tree.find(5, binary_tree.root)
p binary_tree.level_order(binary_tree.root)
p binary_tree.inorder(binary_tree.root)