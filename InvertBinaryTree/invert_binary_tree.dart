/*


-* Invert Binary Tree *-

Given the root of a binary tree, invert the tree, and return its root.



Example 1:


Input: root = [4,2,7,1,3,6,9]
Output: [4,7,2,9,6,3,1]
Example 2:


Input: root = [2,1,3]
Output: [2,3,1]
Example 3:

Input: root = []
Output: []


Constraints:

The number of nodes in the tree is in the range [0, 100].
-100 <= Node.val <= 100

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
  // recursive
  TreeNode? invertTree(TreeNode? root) {
    if (root == null) return null;
    TreeNode? tempRight = root.right;
    root.right = invertTree(root.left);
    root.left = invertTree(tempRight);
    return root;
  }
}

class B {
  // Using Queue
  TreeNode? invertTree(TreeNode? root) {
    if (root == null) return null;

    final Queue<TreeNode> stack = Queue();
    stack.add(root);

    while (stack.isNotEmpty) {
      final TreeNode node = stack.removeLast();
      final TreeNode? left = node.left;
      node.left = node.right;
      node.right = left;

      if (node.left != null) stack.add(node.left!);

      if (node.right != null) stack.add(node.right!);
    }
    return root;
  }
}

class C {
  // Depth First Search
  TreeNode? invertTree(TreeNode? root) {
    if (root == null) return null;

    final Queue<TreeNode> queue = Queue();
    queue.add(root);

    while (queue.isNotEmpty) {
      final TreeNode node = queue.removeFirst();
      final TreeNode? left = node.left;
      node.left = node.right;
      node.right = left;

      if (node.left != null) queue.add(node.left!);

      if (node.right != null) queue.add(node.right!);
    }
    return root;
  }
}
