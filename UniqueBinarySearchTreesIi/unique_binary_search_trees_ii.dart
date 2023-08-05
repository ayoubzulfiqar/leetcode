/*

-* 95. Unique Binary Search Trees II *-

Given an integer n, return all the structurally unique BST's (binary search trees), which has exactly n nodes of unique values from 1 to n. Return the answer in any order.

 

Example 1:


Input: n = 3
Output: [[1,null,2,null,3],[1,null,3,2],[2,1,3],[3,1,null,null,2],[3,2,null,1]]
Example 2:

Input: n = 1
Output: [[1]]
 

Constraints:

1 <= n <= 8


*/

// Definition for a binary tree node.
class TreeNode {
  int val;
  TreeNode? left;
  TreeNode? right;

  TreeNode(this.val, [this.left, this.right]);
}

class Solution {
  TreeNode? insert(int x, TreeNode? t) {
    if (t != null) {
      if (x > t.val) {
        t.right = insert(x, t.right);
      } else {
        t.left = insert(x, t.left);
      }
      return t;
    } else {
      return TreeNode(x);
    }
  }

  List<TreeNode?> generateTrees(int n) {
    if (n == 0) return <TreeNode?>[];

    final List<List<TreeNode?>> lists = <List<TreeNode?>>[[]];
    lists[0].add(null);

    for (int len = 1; len <= n; len++) {
      final List<TreeNode?> newTrees = <TreeNode?>[];
      for (int root = 1; root <= len; root++) {
        for (TreeNode? left in lists[root - 1]) {
          for (TreeNode? right in lists[len - root]) {
            TreeNode? rootNode = TreeNode(root);
            rootNode.left = left;
            rootNode.right = cloneTree(right, root);
            newTrees.add(rootNode);
          }
        }
      }
      lists.add(newTrees);
    }

    return lists[n];
  }

  TreeNode? cloneTree(TreeNode? node, int offset) {
    if (node == null) return null;

    TreeNode? newNode = TreeNode(node.val + offset);
    newNode.left = cloneTree(node.left, offset);
    newNode.right = cloneTree(node.right, offset);
    return newNode;
  }
}



String printTree(TreeNode t) {
  return "[${t.val} ${t.left != null ? printTree(t.left!) : ''} ${t.right != null ? printTree(t.right!) : ''}]";
}