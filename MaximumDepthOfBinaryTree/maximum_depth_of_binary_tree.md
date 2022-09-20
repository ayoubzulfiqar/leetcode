# ️‍🔥 Dart ️‍🔥 || 2 - Solutions || line by line explanation

## Solution - 1 Recursive Solution

```dart
class Solution {
// Runtime: 538 ms, faster than 14.29% of Dart online submissions for Maximum Depth of Binary Tree.
// Memory Usage: 141.9 MB, less than 85.71% of Dart online submissions for Maximum Depth of Binary Tree.
  int maxDepth(TreeNode? root) {
    // simply the if the root is null it means it's length is zero
    if (root == null) return 0;
    // from the left size length of the root tree all elements on left
    int leftHeight = maxDepth(root.left);
    // from the right side the length of all elements
    int rightHeight = maxDepth(root.right);
    // using max to find the length because it's start from zero (index) so
    // we add one to start from point 1
    return 1 + max(leftHeight, rightHeight);
  }
}
```

## Solution - 2 Level Order Traversal

```dart
class Solution {
// Runtime: 437 ms, faster than 50.00% of Dart online submissions for Maximum Depth of Binary Tree.
// Memory Usage: 145.7 MB, less than 21.43% of Dart online submissions for Maximum Depth of Binary Tree.
  int maxDepth(TreeNode? root) {
    // if the whole  root is empty it's length is zero
    if (root == null) return 0;
    // using Queue to manipulate values from both ends
    Queue<TreeNode?> q = Queue();
    // depth hold our result like how much deep our queue is.
    // based on it's length
    int queueDepth = 0;
    // adding the whole root tree inside queue
    q.add(root);
    // while it's not empty
    while (q.isNotEmpty) {
      // we get the length of the whole queue
      int size = q.length;
      // iterate through each element inside queue
      for (int i = 0; i < size; i++) {
        // than we will remove the first element from the tree
        TreeNode? node = q.removeFirst();
        // if left and right are not null of anything empty we will add the both left and right
        if (node?.left != null) q.add(node?.left);
        if (node?.right != null) q.add(node?.right);
      }
      // after adding we will increment the value
      queueDepth++;
    }

    return queueDepth;
  }
}
```
