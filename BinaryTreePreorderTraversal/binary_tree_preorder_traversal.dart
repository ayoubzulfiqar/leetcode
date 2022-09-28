/*

-* Binary Tree Pre-Order Traversal *-

Given the root of a binary tree, return the preorder traversal of its nodes' values.



Example 1:


Input: root = [1,null,2,3]
Output: [1,2,3]
Example 2:

Input: root = []
Output: []
Example 3:

Input: root = [1]
Output: [1]


Constraints:

The number of nodes in the tree is in the range [0, 100].
-100 <= Node.val <= 100


Follow up: Recursive solution is trivial, could you do it iteratively?



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
// Recursion
// Runtime: 448 ms, faster than 77.78% of Dart online submissions for Binary Tree Preorder Traversal.
// Memory Usage: 140.1 MB, less than 88.89% of Dart online submissions for Binary Tree Preorder Traversal.
  List<int> preorderTraversal(TreeNode? root) {
    List<int> list = List.empty(growable: true);
    preOrder(root, list);
    return list;
  }

  void preOrder(TreeNode? root, List<int> list) {
    if (root == null) return;
    list.add(root.val);
    preOrder(root.left, list);
    preOrder(root.right, list);
  }
}

class B {
  // Iterative Approach Using Stack
// Runtime: 503 ms, faster than 44.44% of Dart online submissions for Binary Tree Preorder Traversal.
// Memory Usage: 142.7 MB, less than 16.67% of Dart online submissions for Binary Tree Preorder Traversal.
  List<int> preorderTraversal(TreeNode? root) {
    // Create an array list to store the solution result...
    List<int> sol = List.empty(growable: true);
    // Return the solution answer if the tree is empty...
    if (root == null) return sol;
    // Create an empty stack and push the root node...
    Queue<TreeNode?> bag = Queue();
    bag.add(root);
    // Loop till stack is empty...
    while (!bag.isEmpty) {
      // Pop a node from the stack...
      TreeNode? node = bag.removeLast();
      sol.add(node!.val);
      // Push the right child of the popped node into the stack...
      if (node.right != null) bag.add(node.right);
      // Push the left child of the popped node into the stack...
      if (node.left != null) bag.add(node.left);
    }
    return sol; // Return the solution list...
  }
}

class C {
// Runtime: 418 ms, faster than 94.44% of Dart online submissions for Binary Tree Preorder Traversal.
// Memory Usage: 140.6 MB, less than 16.67% of Dart online submissions for Binary Tree Preorder Traversal.
  List<int> preorder = List.empty(growable: true);
  List<int> preorderTraversal(TreeNode? root) {
    if (root == null) return preorder;

    preorder.add(root.val);
    preorderTraversal(root.left);
    preorderTraversal(root.right);

    return preorder;
  }
}
