require 'pry'

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

    def insert(value, root = @root) # takes in a value and root of a binary search tree and binary tree will be updated with the new value as a leaf node

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

    def delete(value, root = @root) # your inputs are a value and the binary tree and the output is the updated binary tree with the deleted node

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

    def find(value, root = @root)
        
        return nil if root.data.nil? 

        if root.data == value
            return root
        elsif value > root.data
            find(value, root.right)
        elsif value < root.data
            find(value, root.left)
        end

    end

    def level_order(root = @root)

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

    def inorder(root = @root, arr = [])
        
        return arr if root.nil?

        # THIS CODE ONLY WORKS BECAUSE OF RUBY'S IMPLICIT RETURN FUNCTIONALITY
        # the better way to do this would be to do it explicitly with CONCAT 

        inorder(root.left, arr)
        arr << root.data
        inorder(root.right, arr)

    end

    def inorder2(current_node = root)
        
        #This is the better way to do it because it has an explicit return
        
        return [] if current_node.nil?
  
        result = []
  
        result.concat(inorder(current_node.left)) unless current_node.left.nil?
        result << current_node.data
        result.concat(inorder(current_node.right)) unless current_node.right.nil?
  
        result
      end

    def preorder(root = @root, arr=[])

        return arr if root.nil?

        # THIS CODE ONLY WORKS BECAUSE OF RUBY'S IMPLICIT RETURN FUNCTIONALITY
        # the better way to do this would be to do it explicitly with CONCAT 
        arr << root.data
        inorder(root.left, arr)
        inorder(root.right, arr)
    end 

    def postorder(root = @root, arr=[])

        return arr if root.nil?

        # THIS CODE ONLY WORKS BECAUSE OF RUBY'S IMPLICIT RETURN FUNCTIONALITY
        # the better way to do this would be to do it explicitly with CONCAT 
        inorder(root.left, arr)
        inorder(root.right, arr)
        arr << root.data
    end 

    def height(root = @root)        

        return 0 if root.nil?

        h = 1 # if the root is not nil, then the height is 1 for the node

        # tests the height of the left subtree and the right subtree
        a = height(root.left)
        b = height(root.right)
        # returns the max height of the left subtree and the right subtree
        max = a > b ? a : b

        h += max # adds the max height of the left / right subtree to the height of the parent

        return h

    end

    def depth(node, tree = @root) #accepts a node and returns its depth

        # traverse tree to find node
        
        return nil if tree.nil?

        d = 1 # depth is at least equal to 1

        if tree.data == node.data
            return d
        elsif node.data > tree.data
            d += depth(node, tree.right)
        elsif node.data < tree.data
            d += depth(node, tree.left)
        end

        d

    end

    def balanced?(root = @root)

        return true if root.nil?

        current_node_balanced = (height(root.left) - height(root.right)).abs < 2

        return current_node_balanced && balanced?(root.left) && balanced?(root.right)

    end

    def rebalance(root = @root)

        arr = inorder(root)
        @root = build_tree(arr)

    end

    def pretty_print(node = root, prefix="", is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? "│ " : " "}", false) if node.right
        puts "#{prefix}#{is_left ? "└── " : "┌── "}#{node.data.to_s}"
        pretty_print(node.left, "#{prefix}#{is_left ? " " : "│ "}", true) if node.left
    end

end

