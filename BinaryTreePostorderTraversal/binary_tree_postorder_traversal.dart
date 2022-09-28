/*

-* Binary Tree Postorder Traversal *-
Given the root of a binary tree, return the postorder traversal of its nodes' values.



Example 1:


Input: root = [1,null,2,3]
Output: [3,2,1]
Example 2:

Input: root = []
Output: []
Example 3:

Input: root = [1]
Output: [1]


Constraints:

The number of the nodes in the tree is in the range [0, 100].
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

class C {
  /*
  3. Postorder Traversal
Step 1: Traverse the left subtree, i.e., call Preorder(left->subtree)
Step 2: Traverse the right subtree, i.e., call Inorder(right->subtree)
Step 3: Visit the root.

  */
// Runtime: 513 ms, faster than 18.18% of Dart online submissions for Binary Tree Postorder Traversal.
// Memory Usage: 140.7 MB, less than 36.36% of Dart online submissions for Binary Tree Postorder Traversal.
  List<int> postorderTraversal(TreeNode? root) {
    List<int> ans = List.empty(growable: true);
    solve(root, ans);
    return ans;
  }

  void solve(TreeNode? root, List<int> ans) {
    // Base case
    if (root == null) return;

    // Preorder Traversal = LEFT - RIGHT - ROOT
    solve(root.left, ans);
    solve(root.right, ans);
    ans.add(root.val);
  }
}

class E {
  // (Iterative Approach Using Stack
// Runtime: 462 ms, faster than 63.64% of Dart online submissions for Binary Tree Postorder Traversal.
// Memory Usage: 143.1 MB, less than 18.18% of Dart online submissions for Binary Tree Postorder Traversal.
  List<int> postorderTraversal(TreeNode? root) {
    // Create an array list to store the solution result...
    List<int> sol = List.empty(growable: true);
    // Return the solution answer if the tree is empty...
    if (root == null) return sol;
    // Create an empty stack and push the root node...
    Queue<TreeNode?> bag = Queue();
    bag.add(root);
    // Loop till stack is empty...
    while (!bag.isEmpty) {
      // set peek a node from the stack...
      TreeNode? node = bag.last;
      // If the subtrees of that node are null, then pop & store the pop value into solution result...
      if (node?.left == null && node?.right == null) {
        TreeNode? pop = bag.removeLast();
        sol.add(pop!.val);
      } else {
        // Push the right child of the popped node into the stack...
        if (node?.right != null) {
          bag.add(node?.right);
          node?.right = null;
        }
        // Push the left child of the popped node into the stack...
        if (node?.left != null) {
          bag.add(node?.left);
          node?.left = null;
        }
      }
    }
    return sol; // Return the solution list...
  }
}

class F {
// Runtime: 465 ms, faster than 63.64% of Dart online submissions for Binary Tree Postorder Traversal.
// Memory Usage: 140.4 MB, less than 63.64% of Dart online submissions for Binary Tree Postorder Traversal.
  List<int> list = [];
  List<int> postorderTraversal(TreeNode? root) {
    if (root == null) return list;

    postorderTraversal(root.left);
    postorderTraversal(root.right);
    list.add(root.val);
    return list;
  }
}
