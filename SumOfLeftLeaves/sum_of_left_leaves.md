# 🔥 Sum of Lef Leaves 🔥 || Simple Fast and Easy || with Explanation

## Solution - 1

## Explanation

The given code is a recursive function to find the sum of the values of left leaves in a binary tree. The function takes a TreeNode pointer as its parameter, representing the root of the binary tree.

In the Go implementation, we define a TreeNode struct with fields for the value (Val), the left child (Left), and the right child (Right).

The sumOfLeftLeaves function starts with a base case that checks if the root is nil. If the root is nil, it means we have reached the end of a branch, so we return 0.

Next, we initialize a variable sum to keep track of the sum of the left leaves.

The following if statement checks if the current node has a left child (root.Left != nil) and if that left child is a leaf node (it has no left or right children: root.Left.Left == nil && root.Left.Right == nil). If these conditions are met, we add the value of the left child to the sum.

After that, we make two recursive calls to sumOfLeftLeaves, one with the left child as the parameter and the other with the right child. This allows us to traverse the entire tree, summing the values of the left leaves at each step.

Finally, we return the accumulated sum value, which represents the sum of all the left leaves in the binary tree.

You can call the sumOfLeftLeaves function from the main function by creating a binary tree and passing its root as an argument to the function.

```dart

class TreeNode {
  int val;
  TreeNode? left;
  TreeNode? right;
  TreeNode([this.val = 0, this.left, this.right]);
}

class Solution {
  int sumOfLeftLeaves(TreeNode? root) {
    if (root == null) return 0;

    int sum = 0;
    if (root.left != null &&
        root.left?.left == null &&
        root.left?.right == null) {
      sum += root.left!.val;
    }
    sum += sumOfLeftLeaves(root.left);
    sum += sumOfLeftLeaves(root.right);
    return sum;
  }
}
```

## Solution - 2

```dart
class Solution {
  int sumOfLeftLeaves(TreeNode? root) {
    final List<_StackEntry> stack = <_StackEntry>[];
    stack.add(_StackEntry(root, false));
    int ans = 0;

    while (stack.isNotEmpty) {
      _StackEntry entry = stack.removeLast();
      TreeNode? cur = entry.node;
      bool isLeft = entry.isLeft;

      if (cur!.left == null && cur.right == null && isLeft) {
        ans += cur.val;
      }

      if (cur.right != null) {
        stack.add(_StackEntry(cur.right, false));
      }

      if (cur.left != null) {
        stack.add(_StackEntry(cur.left, true));
      }
    }

    return ans;
  }
}

class _StackEntry {
  TreeNode? node;
  bool isLeft;

  _StackEntry(this
  .node, this.isLeft);
}
```

## Solution - 3 Morris Traversal

```dart
class Solution {
  int sumOfLeftLeaves(TreeNode? root) {
    int ans = 0;
    while (root != null) {
      if (root.left != null) {
        var pre = root.left;
        while (pre!.right != null && pre.right != root) {
          pre = pre.right;
        }

        if (pre.right == null) {
          pre.right = root;
          root = root.left;
        } else {
          pre.right = null;

          if (pre == root.left && pre.left == null) {
            ans += pre.val;
          }
          root = root.right;
        }
      } else {
        root = root.right;
      }
    }
    return ans;
  }
}
```
