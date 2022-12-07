/*


-* 938. Range Sum of BST *-


Given the root node of a binary search tree and two integers low and high, return the sum of values of all nodes with a value in the inclusive range [low, high].

 

Example 1:


Input: root = [10,5,15,3,7,null,18], low = 7, high = 15
Output: 32
Explanation: Nodes 7, 10, and 15 are in the range [7, 15]. 7 + 10 + 15 = 32.
Example 2:


Input: root = [10,5,15,3,7,13,18,1,null,6], low = 6, high = 10
Output: 23
Explanation: Nodes 6, 7, and 10 are in the range [6, 10]. 6 + 7 + 10 = 23.
 

Constraints:

The number of nodes in the tree is in the range [1, 2 * 104].
1 <= Node.val <= 105
1 <= low <= high <= 105
All Node.val are unique.


*/

// Definition for a binary tree node.
class TreeNode {
  int val;
  TreeNode? left;
  TreeNode? right;
  TreeNode([this.val = 0, this.left, this.right]);
}

class A {
  int rangeSumBST(TreeNode? root, int low, int high) {
    if (root == null) return 0; // base case.
    if (root.val < low)
      return rangeSumBST(root.right, low, high); // left branch excluded.
    if (root.val > high)
      return rangeSumBST(root.left, low, high); // right branch excluded.
    return root.val +
        rangeSumBST(root.right, low, high) +
        rangeSumBST(root.left, low, high); // count in both children.
  }
}

class B {
  int rangeSumBST(TreeNode? root, int low, int high) {
    if (root == null) return 0; // base case.
    return (low <= root.val && root.val <= high ? root.val : 0) +
        rangeSumBST(root.right, low, high) +
        rangeSumBST(root.left, low, high);
  }
}

class C {
  int rangeSumBST(TreeNode? root, int low, int high) {
    List<TreeNode?> stk = [];
    stk.add(root);
    int sum = 0;
    while (stk.isNotEmpty) {
      TreeNode? n = stk.removeLast();
      if (n == null) {
        continue;
      }
      if (n.val > low) {
        stk.add(n.left);
      } // left child is a possible candidate.
      if (n.val < high) {
        stk.add(n.right);
      } // right child is a possible candidate.
      if (low <= n.val && n.val <= high) {
        sum += n.val;
      }
    }
    return sum;
  }
}
