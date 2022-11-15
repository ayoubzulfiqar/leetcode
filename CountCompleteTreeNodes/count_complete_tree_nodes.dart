/*


-* 222. Count Complete Tree Nodes *-

Given the root of a complete binary tree, return the number of the nodes in the tree.

According to Wikipedia, every level, except possibly the last, is completely filled in a complete binary tree, and all nodes in the last level are as far left as possible. It can have between 1 and 2h nodes inclusive at the last level h.

Design an algorithm that runs in less than O(n) time complexity.



Example 1:


Input: root = [1,2,3,4,5,6]
Output: 6
Example 2:

Input: root = []
Output: 0
Example 3:

Input: root = [1]
Output: 1


Constraints:

The number of nodes in the tree is in the range [0, 5 * 104].
0 <= Node.val <= 5 * 104
The tree is guaranteed to be complete.


*/

// Definition for a binary tree node.
import 'dart:collection';
import 'dart:math';

class TreeNode {
  int val;
  TreeNode? left;
  TreeNode? right;
  TreeNode([this.val = 0, this.left, this.right]);
}

class A {
  int countNodes(TreeNode? root) {
    if (root == null) return 0;
    return countNodes(root.left) + countNodes(root.right) + 1;
  }
}

class B {
  int countNodes(TreeNode? root) {
    if (root == null) {
      return 0;
    }
    int left = 0, right = 0;
    TreeNode? leftNode = root, rightNode = root;
    while (leftNode != null) {
      left++;
      leftNode = leftNode.left;
    }

    while (rightNode != null) {
      right++;
      rightNode = rightNode.right;
    }

    if (left == right) {
      return pow(2, right).toInt() - 1;
    }

    return 1 + countNodes(root.left) + countNodes(root.right);
  }
}

class C {
  int count = 0;
  void solve(
    TreeNode? root,
  ) {
    if (root == null) return;

    count++;
    if (root.left != null) solve(root.left);
    if (root.right != null) solve(root.right);
  }

  int countNodes(TreeNode? root) {
    solve(root);
    return count;
  }
}

class D {
  int countNodes(TreeNode? root) {
    int count = 0;
    if (root == null) return 0;

    Queue<TreeNode?> q = Queue();
    q.add(root);

    while (!q.isEmpty) {
      root = q.first;
      q.removeFirst();
      if (root == null) {
        if (!q.isEmpty) q.add(null);
      } else {
        count++;
        if (root.left != null) q.add(root.left);
        if (root.right != null) q.add(root.right);
      }
    }

    return count;
  }
}
