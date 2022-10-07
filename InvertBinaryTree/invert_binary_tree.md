# 🔥 Invert Binary Tree 🔥 || 3 Solutions || Simple Fast and Easy || with Explanation

## Definition for a binary tree node

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
  TreeNode? invertTree(TreeNode? root) {
    if (root == null) return null;
    TreeNode? tempRight = root.right;
    root.right = invertTree(root.left);
    root.left = invertTree(tempRight);
    return root;
  }
}
```

## Solution - 2 Using Queue as Stack

```dart
import 'dart:collection';

class Solution {
  TreeNode? invertTree(TreeNode? root) {
    if (root == null) return null;

    final Queue<TreeNode> stack = Queue();
    stack.add(root);

    while (stack.isNotEmpty) {
      final TreeNode node = stack.removeLast();
      final TreeNode? left = node.left;
      node.left = node.right;
      node.right = left;

      if (node.left != null) stack.add(node.left!);

      if (node.right != null) stack.add(node.right!);
    }
    return root;
  }
}
```

## Solution - 3 BFS (Level Order Traversal)

```dart
import 'dart:collection';

class Solution {
  TreeNode? invertTree(TreeNode? root) {
    if (root == null) return null;

    final Queue<TreeNode> queue = Queue();
    queue.add(root);

    while (queue.isNotEmpty) {
      final TreeNode node = queue.removeFirst();
      final TreeNode? left = node.left;
      node.left = node.right;
      node.right = left;

      if (node.left != null) queue.add(node.left!);

      if (node.right != null) queue.add(node.right!);
    }
    return root;
  }
}
```
