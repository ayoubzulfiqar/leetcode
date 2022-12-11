/*


-* 124. Binary Tree Maximum Path Sum *-



A path in a binary tree is a sequence of nodes where each pair of adjacent nodes in the sequence has an edge connecting them. A node can only appear in the sequence at most once. Note that the path does not need to pass through the root.

The path sum of a path is the sum of the node's values in the path.

Given the root of a binary tree, return the maximum path sum of any non-empty path.

 

Example 1:


Input: root = [1,2,3]
Output: 6
Explanation: The optimal path is 2 -> 1 -> 3 with a path sum of 2 + 1 + 3 = 6.
Example 2:


Input: root = [-10,9,20,null,null,15,7]
Output: 42
Explanation: The optimal path is 15 -> 20 -> 7 with a path sum of 15 + 20 + 7 = 42.
 

Constraints:

The number of nodes in the tree is in the range [1, 3 * 104].
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

class A {
  int val = -1000;
  int maxPathSum(TreeNode? root) {
    postOrder(root);
    return val;
  }

  int postOrder(TreeNode? root) {
    if (root == null) return 0;
    int sumLeft = postOrder(root.left);
    int sumRight = postOrder(root.right);
    int maxi = max(
        root.val,
        max(root.val + sumLeft,
            max(root.val + sumRight, root.val + sumRight + sumLeft)));
    if (maxi > val) val = maxi;
    return root.val > root.val + max(sumLeft, sumRight)
        ? root.val
        : root.val + max(sumLeft, sumRight);
  }
}

class B {
  int maxPathSum(TreeNode? root) {
    List<int> maxi = [1];
    maxi[0] = -1000;
    pathDown(maxi, root);
    return maxi[0];
  }

  int pathDown(List<int> maxi, TreeNode? root) {
    if (root == null) return 0;
    int leftMax = max(0, pathDown(maxi, root.left));
    int rightMax = max(0, pathDown(maxi, root.right));
    maxi[0] = max(maxi[0], root.val + leftMax + rightMax);
    return root.val + max(leftMax, rightMax);
  }
}

class C {
  int maxPathSum(TreeNode? root) {
    int maxi = -1000;
    List<TreeNode> stack = [];
    TreeNode? pre = root;
    TreeNode? cur = root;
    TreeNode? old = null;
    while (stack.isNotEmpty || cur != null) {
      while (cur != null) {
        stack.add(cur);
        cur = cur.left;
      }
      if (stack.isNotEmpty) {
        pre = stack.last;
        cur = pre.right;

        if (cur == null || cur == old) {
          stack.removeLast();
          int left = pre.left == null ? 0 : pre.left!.val;
          int right = cur == null ? 0 : cur.val;

          maxi = max(
              maxi,
              max(
                  pre.val,
                  max(pre.val + left,
                      max(pre.val + right, pre.val + left + right))));
          pre.val = max(pre.val, max(pre.val + right, pre.val + left));

          old = pre;
          cur = null;
        } else
          old = cur;
      }
    }
    return maxi;
  }
}
