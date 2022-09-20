# 🔥 Dart 🔥 || 3 solution || Recursive - Iterative - PostOrder traversal

## Definition for a Binary Tree Node

```dart
class TreeNode {
  int val;
  TreeNode? left;
  TreeNode? right;
  TreeNode([this.val = 0, this.left, this.right]);
}
```

## Solution - 1 Recursive

```dart
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
```

## Solution - 2 PostOrder traversal

```dart

import 'dart:collection';

class Solution {
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
```

## Solution - 3 Iterative

```dart

class Solution {
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
```

## Bonus Solution - Golang - Recursive 100% fast 0ms

```go
// Definition for a binary tree node.
type TreeNode struct {
 Val   int
 Left  *TreeNode
 Right *TreeNode
}

// Runtime: 0 ms, faster than 100.00% of Go online submissions for Path Sum.
// Memory Usage: 4.6 MB, less than 94.24% of Go online submissions for Path Sum.
func hasPathSum(root *TreeNode, targetSum int) bool {
 if root == nil {
  return false
 }
 if root.Left == nil && root.Right == nil {
  return root.Val == targetSum
 }
 return hasPathSum(root.Left, targetSum-root.Val) ||
  hasPathSum(root.Right, targetSum-root.Val)
}
```
