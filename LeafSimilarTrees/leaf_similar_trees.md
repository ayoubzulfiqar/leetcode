# 🔥 Leaf-Similar Trees 🔥 || Simple Fast and Easy || with Explanation

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
  int dfs(List<TreeNode?> s) {
    while (true) {
      TreeNode? node = s.removeLast();
      if (node?.right != null) s.add(node?.right);
      if (node?.left != null) s.add(node?.left);
      if (node?.left == null && node?.right == null) return node!.val;
    }
  }

  bool leafSimilar(TreeNode? root1, TreeNode? root2) {
    List<TreeNode?> s1 = [], s2 = [];
    s1.add(root1);
    s2.add(root2);
    while (s1.isNotEmpty && s2.isNotEmpty) if (dfs(s1) != dfs(s2)) return false;
    return s1.isEmpty && s2.isEmpty;
  }
}
```

## Solution - 2

```dart
class Solution {
  void getLeaf(TreeNode? root, List<int> l) {
    if (root == null) return;
    if (root.left == null && root.right == null) {
      l.add(root.val);
      return;
    }
    getLeaf(root.left, l);
    getLeaf(root.right, l);
  }

  bool leafSimilar(TreeNode? root1, TreeNode? root2) {
    List<int> l1 = [], l2 = [];
    getLeaf(root1, l1);
    getLeaf(root2, l2);
    if (l1.length != l2.length) return false;
    for (int i = 0; i < l1.length; ++i) if (l1[i] != l2[i]) return false;
    return true;
  }
}
```
