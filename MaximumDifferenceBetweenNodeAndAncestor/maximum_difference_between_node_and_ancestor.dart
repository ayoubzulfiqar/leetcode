/*


-* 1026. Maximum Difference Between Node and Ancestor *-




Given the root of a binary tree, find the maximum value v for which there exist different nodes a and b where v = |a.val - b.val| and a is an ancestor of b.

A node a is an ancestor of b if either: any child of a is equal to b or any child of a is an ancestor of b.

 

Example 1:


Input: root = [8,3,10,1,6,null,14,null,null,4,7,13]
Output: 7
Explanation: We have various ancestor-node differences, some of which are given below :
|8 - 3| = 5
|3 - 7| = 4
|8 - 1| = 7
|10 - 13| = 3
Among all possible differences, the maximum value of 7 is obtained by |8 - 1| = 7.
Example 2:


Input: root = [1,null,2,null,0,3]
Output: 3
 

Constraints:

The number of nodes in the tree is in the range [2, 5000].
0 <= Node.val <= 105

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
  int m = 0;
  List<int>? dfs(TreeNode? root) {
    if (root == null) return null;
    List<int>? left = dfs(root.left);
    List<int>? right = dfs(root.right);
    if (left == null && right == null) {
      return [root.val, root.val];
    }
    int mini = root.val;
    int maxi = root.val;
    if (left != null) {
      m = max(m, (left[0] - root.val).abs());
      m = max(m, (left[1] - root.val).abs());
      mini = min(mini, left[0]);
      maxi = max(maxi, left[1]);
    }
    if (right != null) {
      m = max(m, (right[0] - root.val).abs());
      m = max(m, (right[1] - root.val).abs());
      mini = min(mini, right[0]);
      maxi = max(maxi, right[1]);
    }

    return [mini, maxi];
  }

  int maxAncestorDiff(TreeNode? root) {
    if (root == null) return 0;
    dfs(root);
    return m;
  }
}

class B {
  /*
  Maintain a min and max seen so far as we explore the tree in DFS fashion.
  At every node, we can update the ret by comparing it with min and max.
  */
  int ret = 0;
  void helper(TreeNode? current, int mini, int maxi) {
    if (current != null) {
      ret = max(ret, (mini - current.val).abs());
      ret = max(ret, (maxi - current.val).abs());
      if (current.left != null)
        helper(current.left, min(mini, current.left!.val),
            max(maxi, current.left!.val));
      if (current.right != null)
        helper(current.right, min(mini, current.right!.val),
            max(maxi, current.right!.val));
    }
  }

  int maxAncestorDiff(TreeNode? root) {
    helper(root, root!.val, root.val);
    return ret;
  }
}

class C {
  int maxVal(TreeNode? root, int min, int max, int maxValTotal) {
    if (root == null) return maxValTotal;
    if (root.val > max)
      max = root.val;
    else if (root.val < min) min = root.val;
    maxValTotal = (max - min).abs();

    int maxValLeft = maxVal(root.left, min, max, maxValTotal);
    if (maxValLeft > maxValTotal) maxValTotal = maxValLeft;

    int maxValRight = maxVal(root.right, min, max, maxValTotal);
    if (maxValRight > maxValTotal) maxValTotal = maxValRight;

    return maxValTotal;
  }

  int maxAncestorDiff(TreeNode? root) {
    int value = maxVal(root, root!.val, root.val, 0);

    return value;
  }
}
