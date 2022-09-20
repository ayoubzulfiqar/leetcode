/*

 -* Balanced Binary Tree *-


Given a binary tree, determine if it is height-balanced.

For this problem, a height-balanced binary tree is defined as:

a binary tree in which the left and right subtrees of every node differ in height by no more than 1.



Example 1:


Input: root = [3,9,20,null,null,15,7]
Output: true
Example 2:


Input: root = [1,2,2,3,3,null,null,4,4]
Output: false
Example 3:

Input: root = []
Output: true


Constraints:

The number of nodes in the tree is in the range [0, 5000].
-104 <= Node.val <= 104


*/

// Definition for a binary tree node.
import 'dart:math';

class TreeNode {
  int val;
  TreeNode? left;
  TreeNode? right;
  TreeNode([this.val = 0, this.left, this.right]);
}

class Solution {
//   Runtime: 328 ms, faster than 87.50% of Dart online submissions for Balanced Binary Tree.
// Memory Usage: 161.2 MB, less than 12.50% of Dart online submissions for Balanced Binary Tree.
  bool isBalanced(TreeNode? root) {
    int getHeight(TreeNode? node) {
      if (node == null) return 0;

      int left = getHeight(node.left);
      int right = getHeight(node.right);

      // left, right subtree is unbalanced or cur tree is unbalanced
      if (left == -1 || right == -1 || (left - right).abs() > 1) return -1;

      return max(left, right) + 1;
    }

    return getHeight(root) != -1;
  }
}

class B {
  bool isBalanced(TreeNode? root) {
    // case [] empty or null
    if (root == null) return true;
    // abs function return the absolution value
    if ((getHeightOfSubTree(root.left) - getHeightOfSubTree(root.right)).abs() >
        1) return false;
    //if both are balanced return true else return false
    if (isBalanced(root.left) && isBalanced(root.right)) return true;

    return false;
  }

  int getHeightOfSubTree(TreeNode? node) {
    // case [] empty or null
    if (node == null) return 0;
    // adding one to both max value on both sides
    return 1 +
        max(getHeightOfSubTree(node.left), getHeightOfSubTree(node.right));
  }
}

class C {
//   Runtime: 564 ms, faster than 25.00% of Dart online submissions for Balanced Binary Tree.
// Memory Usage: 143.6 MB, less than 75.00% of Dart online submissions for Balanced Binary Tree.
  bool isBalanced(TreeNode? root) {
    bool ans = true;
    int height(TreeNode? root) {
      if (root == null) return 0;
      int l = height(root.left);
      int r = height(root.right);
      if ((l - r).abs() > 1) ans = false;
      return max(l, r) + 1;
    }

    if (root == null) return true;
    height(root);
    return ans;
  }
}
