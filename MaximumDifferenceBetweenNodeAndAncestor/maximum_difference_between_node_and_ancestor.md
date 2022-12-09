# 🔥 3 Approaches 🔥 || Simple Fast and Easy || with Explanation

## Definition for a binary tree node

```dart
class TreeNode {
  int val;
  TreeNode? left;
  TreeNode? right;
  TreeNode([this.val = 0, this.left, this.right]);
}
```

## Solution -1 DFS

```dart
class Solution {
  int m = 0;
  List<int>? dfs(TreeNode? root) {
    if (root == null) return null;
    List<int>? left = dfs(root.left);
    List<int>? right = dfs(root.right);
    if (left == null && right == null) {
      return [root.val, root.val];
    }
    int mini = root.val;
    int maxi = root.val;
    if (left != null) {
      m = max(m, (left[0] - root.val).abs());
      m = max(m, (left[1] - root.val).abs());
      mini = min(mini, left[0]);
      maxi = max(maxi, left[1]);
    }
    if (right != null) {
      m = max(m, (right[0] - root.val).abs());
      m = max(m, (right[1] - root.val).abs());
      mini = min(mini, right[0]);
      maxi = max(maxi, right[1]);
    }

    return [mini, maxi];
  }

  int maxAncestorDiff(TreeNode? root) {
    if (root == null) return 0;
    dfs(root);
    return m;
  }
}
```

## Solution - 2 RECURSIVE

```dart
class Solution {
  int ret = 0;
  void helper(TreeNode? current, int mini, int maxi) {
    if (current != null) {
      ret = max(ret, (mini - current.val).abs());
      ret = max(ret, (maxi - current.val).abs());
      if (current.left != null)
        helper(current.left, min(mini, current.left!.val),
            max(maxi, current.left!.val));
      if (current.right != null)
        helper(current.right, min(mini, current.right!.val),
            max(maxi, current.right!.val));
    }
  }

  int maxAncestorDiff(TreeNode? root) {
    helper(root, root!.val, root.val);
    return ret;
  }
}
```

## Solution - 3

```dart
class C {
  int maxVal(TreeNode? root, int min, int max, int maxValTotal) {
    if (root == null) return maxValTotal;
    if (root.val > max)
      max = root.val;
    else if (root.val < min) min = root.val;
    maxValTotal = (max - min).abs();

    int maxValLeft = maxVal(root.left, min, max, maxValTotal);
    if (maxValLeft > maxValTotal) maxValTotal = maxValLeft;

    int maxValRight = maxVal(root.right, min, max, maxValTotal);
    if (maxValRight > maxValTotal) maxValTotal = maxValRight;

    return maxValTotal;
  }

  int maxAncestorDiff(TreeNode? root) {
    int value = maxVal(root, root!.val, root.val, 0);

    return value;
  }
}
```
