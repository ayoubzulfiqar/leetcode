/*

  -* Path Sum *-


  Given the root of a binary tree and an integer targetSum, return true if the tree has a root-to-leaf path such that adding up all the values along the path equals targetSum.

A leaf is a node with no children.



Example 1:


Input: root = [5,4,8,11,null,13,4,7,2,null,null,null,1], targetSum = 22
Output: true
Explanation: The root-to-leaf path with the target sum is shown.
Example 2:


Input: root = [1,2,3], targetSum = 5
Output: false
Explanation: There two root-to-leaf paths in the tree:
(1 --> 2): The sum is 3.
(1 --> 3): The sum is 4.
There is no root-to-leaf path with sum = 5.
Example 3:

Input: root = [], targetSum = 0
Output: false
Explanation: Since the tree is empty, there are no root-to-leaf paths.


Constraints:

The number of nodes in the tree is in the range [0, 5000].
-1000 <= Node.val <= 1000
-1000 <= targetSum <= 1000

*/

// Definition for a binary tree node.
import 'dart:collection';

class TreeNode {
  int val;
  TreeNode? left;
  TreeNode? right;
  TreeNode([this.val = 0, this.left, this.right]);
}

// Recursion Method
class Solution {
// Runtime: 437 ms, faster than 47.06% of Dart online submissions for Path Sum.
// Memory Usage: 143.1 MB, less than 70.59% of Dart online submissions for Path Sum.
  bool hasPathSum(TreeNode? root, int targetSum) {
    if (root == null) return false;
    if (root.left == null && root.right == null && root.val == targetSum)
      return true;
    return hasPathSum(root.left, targetSum - root.val) ||
        hasPathSum(root.right, targetSum - root.val);
  }
}

// PostOrder traversal
class B {
// Runtime: 619 ms, faster than 17.65% of Dart online submissions for Path Sum.
// Memory Usage: 145.5 MB, less than 29.41% of Dart online submissions for Path Sum.
  bool hasPathSum(TreeNode? root, int targetSum) {
    Queue<TreeNode> stack = Queue();
    if (root == null) return false;
    stack.add(root);
    TreeNode? pre = null;
    int target = 0;
    while (!stack.isEmpty) {
      TreeNode? top = stack.last;

      if (pre == null || (pre != top.left && pre != top.right)) {
        target += top.val;
        if (top.right != null) stack.add(top.right!);
        if (top.left != null) stack.add(top.left!);
      } else {
        pre = top;
        stack.removeLast();
        target -= top.val;
      }
      if (top.left == null && top.right == null) {
        if (target == targetSum) return true;
        pre = top;
        stack.removeLast();
        target -= top.val;
      }
    }
    return false;
  }
}

class C {
// Runtime: 483 ms, faster than 41.18% of Dart online submissions for Path Sum.
// Memory Usage: 143.5 MB, less than 47.06% of Dart online submissions for Path Sum.
  bool hasPathSum(TreeNode? root, int targetSum) {
    return calSum(root, targetSum, 0) == 1;
  }

  int calSum(TreeNode? root, int targetSum, int sum) {
    if (root == null) return 0;

    int currentSum = root.val + sum;
    if (root.left == null && root.right == null && currentSum == targetSum)
      return 1;

    return calSum(root.left, targetSum, currentSum) == 1
        ? 1
        : calSum(root.right, targetSum, currentSum);
  }
}

class D {
// Runtime: 565 ms, faster than 17.65% of Dart online submissions for Path Sum.
// Memory Usage: 145.5 MB, less than 29.41% of Dart online submissions for Path Sum.
  bool hasPathSum(TreeNode? root, int targetSum) {
    if (root == null) return false;

    Queue<TreeNode?> stack = Queue();
    stack.add(root);
    int sum = 0;

    while (!stack.isEmpty) {
      TreeNode? current = stack.removeLast();

      if (current?.left == null &&
          current?.right == null &&
          current!.val + sum == targetSum) return true;

      if (current?.left != null) {
        current?.left?.val += current.val;
        stack.add(current?.left);
      }

      if (current?.right != null) {
        current?.right?.val += current.val;
        stack.add(current?.right);
      }
    }

    return false;
  }
}

class E {
  bool hasPathSum(TreeNode? root, int targetSum) {
    return (root?.left ?? root?.right) != null
        ? hasPathSum(root?.left, targetSum - root!.val) ||
            hasPathSum(root.right, targetSum - root.val)
        : (root?.val ?? int) == targetSum;
  }
}
