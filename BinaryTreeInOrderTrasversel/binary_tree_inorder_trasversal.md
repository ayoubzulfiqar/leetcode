# Binary Tree Inorder Traversal Solution in Dart

## Binary Tree

```dart
//- Definition for a binary tree node.

class TreeNode {
  int val;
  TreeNode? left;
  TreeNode? right;
  TreeNode([this.val = 0, this.left, this.right]);
}
```

## Solution - 1

```dart
// Recursive
class A {
  // 70 / 70 test cases passed, but took too long.
  List<int> inorderTraversal(TreeNode? root) {
    List<int> res = <int>[];
    if (root == null) return res;
    helper(root, res);
    return res;
  }

  void helper(TreeNode? root, List<int> res) {
    if (root == null) return;
    helper(root.left, res);
    res.add(root.val);
    helper(root.right, res);
  }
}
```

## Solution - 2

```dart
class B {
  List<int> inorderTraversal(TreeNode? root) {
    List stack = [];
    List<int> ans = [];
    while (root != null || stack.length != 0) {
      while (root != null) {
        stack.add(root);
        root = root.left;
      }
      root = stack.removeLast();
      ans.add(root!.val);
      root = root.right;
    }
    return ans;
  }

  // Runtime: 372 ms, faster than 80.00% of Dart online submissions for Binary Tree Inorder Traversal.
// Memory Usage: 140.2 MB, less than 86.67% of Dart online submissions for Binary Tree Inorder Traversal.
}
```

## Solution - 3

```dart
class C {
  // 70 / 70 test cases passed, but took too long.
  List<int> inorderTraversal(TreeNode? root) {
    List<int> ans = <int>[];
    inOrder(root, ans);
    return ans;
  }

  void inOrder(TreeNode? root, List<int> ans) {
    while (root != null) {
      if (root.left == null) {
        ans.add(root.val);
        root = root.right;
      } else {
        TreeNode? temp = getPreOrderSuccessor(root);
        temp.right = root;
        TreeNode? left = root.left;
        root.left = null;
        root = left!;
      }
    }
  }

  TreeNode getPreOrderSuccessor(TreeNode root) {
    TreeNode? node = root.left;
    while (node!.right != null) {
      node = node.right;
    }
    return node;
  }
}
```
