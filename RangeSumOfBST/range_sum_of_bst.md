# 🔥 Range Sum of BST 🔥 || Simple Fast and Easy || with Explanation

## Definition for a binary tree node

```dart
class TreeNode {
  int val;
  TreeNode? left;
  TreeNode? right;
  TreeNode([this.val = 0, this.left, this.right]);
}
```

## Solution - 1

```dart
class Solution {
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
```

## Solution - 2

```dart
class Solution {
  int rangeSumBST(TreeNode? root, int low, int high) {
    if (root == null) return 0; // base case.
    return (low <= root.val && root.val <= high ? root.val : 0) +
        rangeSumBST(root.right, low, high) +
        rangeSumBST(root.left, low, high);
  }
}
```

## Solution - 3

```dart
class Solution {
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
```
