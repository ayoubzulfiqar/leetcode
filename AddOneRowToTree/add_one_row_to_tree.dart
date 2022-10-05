/*

  -* Add One Row to Tree *-

Given the root of a binary tree and two integers val and depth, add a row of nodes with value val at the given depth depth.

Note that the root node is at depth 1.

The adding rule is:

Given the integer depth, for each not null tree node cur at the depth depth - 1, create two tree nodes with value val as cur's left subtree root and right subtree root.
cur's original left subtree should be the left subtree of the new left subtree root.
cur's original right subtree should be the right subtree of the new right subtree root.
If depth == 1 that means there is no depth depth - 1 at all, then create a tree node with value val as the new root of the whole original tree, and the original tree is the new root's left subtree.


Example 1:


Input: root = [4,2,6,3,1,5], val = 1, depth = 2
Output: [4,1,1,2,null,null,6,3,1,5]
Example 2:


Input: root = [4,2,null,3,1], val = 1, depth = 3
Output: [4,2,null,1,1,3,null,null,1]


Constraints:

The number of nodes in the tree is in the range [1, 104].
The depth of the tree is in the range [1, 104].
-100 <= Node.val <= 100
-105 <= val <= 105
1 <= depth <= the depth of tree + 1

*/

// Definition for a binary tree node.
import 'dart:collection';

class TreeNode {
  int val;
  TreeNode? left;
  TreeNode? right;
  TreeNode([this.val = 0, this.left, this.right]);
}

class A {
  // Recursive
// Runtime: 586 ms, faster than 100.00% of Dart online submissions for Add One Row to Tree.
// Memory Usage: 146.9 MB, less than 100.00% of Dart online submissions for Add One Row to Tree.
  void walk(TreeNode? root, int val, int depth, int c) {
    // if our root is not null means  we have some value to begin with
    if (root != null) {
      if (c == depth - 1) {
        /// creating the temp node to hold the value of our left node
        TreeNode? temp = root.left;
        // left side of the tree will hold the value of the all the tree node
        root.left = TreeNode(val);
        // now will we will assign he value of the far left side of the tree to our temp node
        root.left?.left = temp;
        // swapping the nodes value left to right
        temp = root.right;
        // right side of the node will hold the tree node value
        root.right = TreeNode(val);
        // than we will assign the value of far right side of the tree to the  temp node we created
        root.right?.right = temp;
        return;
      }
      // than we will walk the tree left to right with it's depth
      walk(root.left, val, depth, c + 1);
      walk(root.right, val, depth, c + 1);
    }
  }

  TreeNode? addOneRow(TreeNode? root, int val, int depth) {
    if (depth == 1) {
      // temp node to hold the value to tree node
      TreeNode? tempNode = TreeNode(val);
      tempNode.left = root;
      return tempNode;
    }
    // walking from the root to each value and depth
    walk(root, val, depth, 1);
    return root;
  }
}

class B {
  // In Order Traversal
// Runtime: 736 ms, faster than 100.00% of Dart online submissions for Add One Row to Tree.
// Memory Usage: 147.4 MB, less than 100.00% of Dart online submissions for Add One Row to Tree.
  TreeNode? addOneRow(TreeNode? root, int val, int depth) {
    TreeNode? inOrder(TreeNode? node, [height = 1, child = '']) {
      if (node == null) {
        return height == depth ? TreeNode(val) : node;
      }

      if (height == depth) {
        // When height matches, insert new node.
        // Also parent has passed which child it is, left or right.
        // Append current tree at appropriate position
        TreeNode newNode = TreeNode(val);
        if (child == 'L' || child == '') {
          newNode.left = node;
        } else if (child == 'R') {
          newNode.right = node;
        }
        return newNode;
      } else if (height < depth) {
        node.left = inOrder(node.left, height + 1, 'L');
        node.right = inOrder(node.right, height + 1, 'R');
        return node;
      }

      return node;
    }

    return inOrder(root);
  }
}

class C {
  // Depth First search - DFS
// Runtime: 675 ms, faster than 100.00% of Dart online submissions for Add One Row to Tree.
// Memory Usage: 149.4 MB, less than 100.00% of Dart online submissions for Add One Row to Tree.
  void walk(TreeNode? currentNode, TreeNode? parentNode, bool left, int val,
      int maxDepth, int currentDepth) {
    // Base case 1
    if (currentDepth == maxDepth - 1) {
      TreeNode node = createNode(val);
      // Base case 2
      if (left) {
        node.left = parentNode?.left;
        parentNode?.left = node;
      } else {
        // Base case 3
        node.right = parentNode?.right;
        parentNode?.right = node;
      }
      return;
    }
    //Base case
    if (currentNode == null) {
      return;
    }
    // Left sub tree
    walk(currentNode.left, currentNode, true, val, maxDepth, currentDepth + 1);
    // right sub tree
    walk(
        currentNode.right, currentNode, false, val, maxDepth, currentDepth + 1);
  }

  TreeNode createNode(int val) {
    return TreeNode(val);
  }

  TreeNode? addOneRow(TreeNode? root, int val, int depth) {
    // Base case 4
    if (depth == 1) {
      TreeNode node = createNode(val);
      node.left = root;
      return node;
    }
    // go for left sub tree.
    walk(root?.left, root, true, val, depth, 1);
    // go for right sub tree.
    walk(root?.right, root, false, val, depth, 1);
    return root;
  }
}

class D {
// Runtime: 523 ms, faster than 100.00% of Dart online submissions for Add One Row to Tree.
// Memory Usage: 143.8 MB, less than 100.00% of Dart online submissions for Add One Row to Tree.
  void levelOrder(TreeNode? root, int val, int depth, int lvl) {
    if (root == null) return;
    if (lvl == depth - 2) {
      TreeNode? l = root.left, r = root.right;
      root.left = TreeNode(val);
      root.left?.left = l;
      root.right = TreeNode(val);
      root.right?.right = r;
    }
    levelOrder(root.left, val, depth, lvl + 1);
    levelOrder(root.right, val, depth, lvl + 1);
  }

  TreeNode? addOneRow(TreeNode? root, int val, int depth) {
    if (depth == 1) {
      TreeNode? node = new TreeNode(val);
      node.left = root;
      return node;
    }
    levelOrder(root, val, depth, 0);
    return root;
  }
}

class E {
// Runtime: 547 ms, faster than 100.00% of Dart online submissions for Add One Row to Tree.
// Memory Usage: 146.9 MB, less than 100.00% of Dart online submissions for Add One Row to Tree.
  TreeNode? addOneRow(TreeNode? root, int val, int depth) {
    // if the depth of the tree is only one
    if (depth == 1) {
      // node will hold our value
      TreeNode node = TreeNode(val);
      // on thee left side
      node.left = root;
      // and we will add the node
      return node;
    }

    Queue<TreeNode?> queue = Queue();
    // add the tree root inn uu queue
    queue.add(root);
    // FOR EXAMPLE IF THE depth is only ne
    int currentDepth = 1;
    // assuming that the queue is not empty
    while (queue.isNotEmpty) {
      // getting the whole length of the queue
      int size = queue.length;
      currentDepth++;

      if (currentDepth == depth) {
        for (int i = 0; i < size; i++) {
          // removing the first value from the queue
          TreeNode? node = queue.removeFirst();
          // our new left node
          TreeNode? newLeftNode = TreeNode(val);
          // assigning the new left node to the left side of the tree node
          newLeftNode.left = node?.left;
          node?.left = newLeftNode;
          // new right node
          TreeNode? newRightNode = TreeNode(val);
          // assigning the new right node to the left side of the tree node
          newRightNode.right = node?.right;
          node?.right = newRightNode;
        }

        break;
      } else {
        // iterating through the whole length of the queue
        for (int i = 0; i < size; i++) {
          // removing the first value
          TreeNode? node = queue.removeFirst();
          // if left side is not null we will add the value to left side
          if (node?.left != null) queue.add(node?.left);
          // if left side is not null we will add the value to left side
          if (node?.right != null) queue.add(node?.right);
        }
      }
    }

    return root;
  }
}
