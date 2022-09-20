/*



-* Minimum Depth of Binary Tree *-

Given a binary tree, find its minimum depth.

The minimum depth is the number of nodes along the shortest path from the root node down to the nearest leaf node.

Note: A leaf is a node with no children.



Example 1:


Input: root = [3,9,20,null,null,15,7]
Output: 2
Example 2:

Input: root = [2,null,3,null,4,null,5,null,6]
Output: 5


Constraints:

The number of nodes in the tree is in the range [0, 105].
-1000 <= Node.val <= 1000



*/

// Definition for a binary tree node.
import 'dart:math';

class TreeNode {
  int val;
  TreeNode? left;
  TreeNode? right;
  TreeNode([this.val = 0, this.left, this.right]);
}

// Time complexity: O(n), Space complexity: O(h), h is tree height
class A {
// Runtime: 854 ms, faster than 20.00% of Dart online submissions for Minimum Depth of Binary Tree.
// Memory Usage: 184.5 MB, less than 60.00% of Dart online submissions for Minimum Depth of Binary Tree.
  int minDepth(TreeNode? root) {
    if (root == null) return 0;
    int left = minDepth(root.left);
    int right = minDepth(root.right);
    //if both left and right 0, that means there is no path in left and right
    // return 1 as current node in the current path
    if (left == 0 && right == 0)
      return 1;
    // if left is 0 and right has some value, that means there is no path in left side
    //but some path in right side, so return whatever value + 1, the extra 1 is for current node
    else if (left == 0)
      return right + 1;
    // if right is 0 and left has some value, that means there is no path in right side
    //but some path in left side, so return whatever value + 1, the extra 1 is for current node
    else if (right == 0)
      return left + 1;
    // if in both side path exist, then consider the minimum and add 1 for the current node
    else
      return min(left, right) + 1;
  }
}

class B {
// 52 / 52 test cases passed, but took too long.
// Status: Time Limit Exceeded
// Submitted: 0 minutes ago

  int minDepth(TreeNode? root) {
    if (root == null) return 0;
    if (root.left == null && root.right == null) return 1;
    int leftDepth =
        root.left != null ? minDepth(root.left) : double.maxFinite.floor();
    int rightDepth =
        root.right != null ? minDepth(root.right) : double.maxFinite.floor();
    return 1 + min(leftDepth, rightDepth);
  }
}

class C {
// Runtime: 687 ms, faster than 20.00% of Dart online submissions for Minimum Depth of Binary Tree.
// Memory Usage: 184.3 MB, less than 80.00% of Dart online submissions for Minimum Depth of Binary Tree.
  int minDepth(TreeNode? root) {
    if (root == null) return 0;

    // Base case
    if (root.left == null && root.right == null) return 1;

    // If left subtree is NULL, recursion for right subtree
    if (root.left == null) return minDepth(root.right) + 1;

    // If right subtree is NULL, recursion for left subtree
    if (root.right == null) return minDepth(root.left) + 1;

    return min(minDepth(root.left), minDepth(root.right)) + 1;
  }
}
