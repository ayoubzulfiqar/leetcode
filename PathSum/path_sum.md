# 🔥 Path Sum 🔥 || 4 solution || Simple Fast and Easy || with Explanation

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
    // if the root is null means empty which means we have nothing to begin with
    if (root == null) return false;
    // now if there is nothing on the left side and also on the
    // right side of the tree and the which mean there is only one value
    // at the top of the root and it's the same that we are looking for
    // than congratulations
    if (root.left == null && root.right == null && root.val == targetSum)
      return true;
      // if not than we will walk on the left side of the tree to find the target value
      // by decrementing the value from the root value
    return hasPathSum(root.left, targetSum - root.val) ||
    // same as above but on the right side of the tree
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
    // queue is our stack which hold our value of the tree
    Queue<TreeNode> stack = Queue();
    // root is null means no value
    if (root == null) return false;
    // we add the value to the our stack
    stack.add(root);
    // if the pervious value of the tree is null
    TreeNode? pre = null;
    int target = 0;
    // assuming that our stack is not empty
    while (stack.isNotEmpty) {
      // the last element on the tree from bottom is our first element because
      // we walking from bottom to top
      TreeNode? top = stack.last;
      // if the previous value is null and previous value is not same on both side
      // of the tree
      if (pre == null || (pre != top.left && pre != top.right)) {
        // we add the value to our target from bottom to top
        target += top.val;
        // if the value on the right is not null than we will add those to our stack
        if (top.right != null) stack.add(top.right!);
        // if the value on the left is not null than we will add those to our stack
        if (top.left != null) stack.add(top.left!);
      } else {
        // our previous will hold the top value
        pre = top;
        // and than we will keep removing the last value
        stack.removeLast();
        // and removing that value from the tree value - bottom to top
        target -= top.val;
      }
      // if the left and right side of the tree are both null
      if (top.left == null && top.right == null) {
        // and the target sum is the the value we are looking for than congratulation
        if (target == targetSum) return true;
        // again our previous will be top(from bottom)
        // to keep track of the value
        pre = top;
        // removing the last element from the stack
        stack.removeLast();
        // removing the target value from the the tree value
        target -= top.val;
      }
    }
    // return g false - means found nothing
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

## Solution - 4

```dart
class E {
  bool hasPathSum(TreeNode? root, int targetSum) {
    return (root?.left ?? root?.right) != null
        ? hasPathSum(root?.left, targetSum - root!.val) ||
            hasPathSum(root.right, targetSum - root.val)
        : (root?.val ?? int) == targetSum;
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
