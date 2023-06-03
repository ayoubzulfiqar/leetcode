/*

-* 404. Sum of Left Leaves *-



Given the root of a binary tree, return the sum of all left leaves.

A leaf is a node with no children. A left leaf is a leaf that is the left child of another node.

 

Example 1:


Input: root = [3,9,20,null,null,15,7]
Output: 24
Explanation: There are two left leaves in the binary tree, with values 9 and 15 respectively.
Example 2:

Input: root = [1]
Output: 0
 

Constraints:

The number of nodes in the tree is in the range [1, 1000].
-1000 <= Node.val <= 1000
*/
/**
 * Definition for a binary tree node.
 * class TreeNode {
 *   int val;
 *   TreeNode? left;
 *   TreeNode? right;
 *   TreeNode([this.val = 0, this.left, this.right]);
 * }
 */

class TreeNode {
  int val;
  TreeNode? left;
  TreeNode? right;
  TreeNode([this.val = 0, this.left, this.right]);
}

class A {
  int sumOfLeftLeaves(TreeNode? root) {
    if (root == null) return 0;

    int sum = 0;
    if (root.left != null &&
        root.left?.left == null &&
        root.left?.right == null) {
      sum += root.left!.val;
    }
    sum += sumOfLeftLeaves(root.left);
    sum += sumOfLeftLeaves(root.right);
    return sum;
  }
}

class B {
  int sumOfLeftLeaves(TreeNode? root) {
    final List<_StackEntry> stack = <_StackEntry>[];
    stack.add(_StackEntry(root, false));
    int ans = 0;

    while (stack.isNotEmpty) {
      _StackEntry entry = stack.removeLast();
      TreeNode? cur = entry.node;
      bool isLeft = entry.isLeft;

      if (cur!.left == null && cur.right == null && isLeft) {
        ans += cur.val;
      }

      if (cur.right != null) {
        stack.add(_StackEntry(cur.right, false));
      }

      if (cur.left != null) {
        stack.add(_StackEntry(cur.left, true));
      }
    }

    return ans;
  }
}

class _StackEntry {
  TreeNode? node;
  bool isLeft;

  _StackEntry(this.node, this.isLeft);
}





class Solution {
  int sumOfLeftLeaves(TreeNode? root) {
    int ans = 0;
    while (root != null) {
      if (root.left != null) {
        var pre = root.left;
        while (pre!.right != null && pre.right != root) {
          pre = pre.right;
        }

        if (pre.right == null) {
          pre.right = root;
          root = root.left;
        } else {
          pre.right = null;

          if (pre == root.left && pre.left == null) {
            ans += pre.val;
          }
          root = root.right;
        }
      } else {
        root = root.right;
      }
    }
    return ans;
  }
}

