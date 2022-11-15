# 🔥 Count Complete Tree Nodes 🔥 || 4 Solutions || Simple Fast and Easy || with Explanation

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
  int countNodes(TreeNode? root) {
    if (root == null) return 0;
    return countNodes(root.left) + countNodes(root.right) + 1;
  }
}
```

## Solution - 2

```dart
class Solution {
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
```

## Solution - 3

```dart
class Solution {
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
```

## Solution - 4

```dart
import 'dart:collection';

class Solution {
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
```
