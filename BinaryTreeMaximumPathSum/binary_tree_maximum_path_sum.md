# 🔥 Binary Tree Maximum Path Sum 🔥 || 3 Approaches || Simple Fast and Easy || with Explanation

## Definition for a binary tree node

```dart
class TreeNode {
  int val;
  TreeNode? left;
  TreeNode? right;
  TreeNode([this.val = 0, this.left, this.right]);
}
```

## Solution - 1 Post-Order Traversal

```dart
class Solution {
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
```

## Solution - 2

```dart
class Solution {
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
```

## Solution - 3 STACK

```dart
class Solution {
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
```
