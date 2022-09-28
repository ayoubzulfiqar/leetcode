# 🔥 Dart || 3 SOlutions || Simple Fast  and Easy with Explanation

## Solution - 1 Postorder Traversal - Recursive

Step 1: Traverse the left subtree, i.e., call Preorder(left->subtree)
Step 2: Traverse the right subtree, i.e., call Inorder(right->subtree)
Step 3: Visit the root.

```dart
class Solution {
// Runtime: 513 ms, faster than 18.18% of Dart online submissions for Binary Tree Postorder Traversal.
// Memory Usage: 140.7 MB, less than 36.36% of Dart online submissions for Binary Tree Postorder Traversal.
  List<int> postorderTraversal(TreeNode? root) {
    List<int> ans = List.empty(growable: true);
    solve(root, ans);
    return ans;
  }

  void solve(TreeNode? root, List<int> ans) {
    // Base case
    if (root == null) return;

    // Preorder Traversal = LEFT - RIGHT - ROOT
    solve(root.left, ans);
    solve(root.right, ans);
    ans.add(root.val);
  }
}
```

## Solution - 2 Iterative Approach Using Stack

```dart
class Solution {
// Runtime: 462 ms, faster than 63.64% of Dart online submissions for Binary Tree Postorder Traversal.
// Memory Usage: 143.1 MB, less than 18.18% of Dart online submissions for Binary Tree Postorder Traversal.
  List<int> postorderTraversal(TreeNode? root) {
    // Create an array list to store the solution result...
    List<int> sol = List.empty(growable: true);
    // Return the solution answer if the tree is empty...
    if (root == null) return sol;
    // Create an empty stack and push the root node...
    Queue<TreeNode?> bag = Queue();
    bag.add(root);
    // Loop till stack is empty...
    while (!bag.isEmpty) {
      // set peek a node from the stack...
      TreeNode? node = bag.last;
      // If the subtrees of that node are null, then pop & store the pop value into solution result...
      if (node?.left == null && node?.right == null) {
        TreeNode? pop = bag.removeLast();
        sol.add(pop!.val);
      } else {
        // Push the right child of the popped node into the stack...
        if (node?.right != null) {
          bag.add(node?.right);
          node?.right = null;
        }
        // Push the left child of the popped node into the stack...
        if (node?.left != null) {
          bag.add(node?.left);
          node?.left = null;
        }
      }
    }
    return sol; // Return the solution list...
  }
}
```

## Solution - 3 Without helper Function

```dart
class Solution {
// Runtime: 465 ms, faster than 63.64% of Dart online submissions for Binary Tree Postorder Traversal.
// Memory Usage: 140.4 MB, less than 63.64% of Dart online submissions for Binary Tree Postorder Traversal.
  List<int> list = [];
  List<int> postorderTraversal(TreeNode? root) {
    if (root == null) return list;

    postorderTraversal(root.left);
    postorderTraversal(root.right);
    list.add(root.val);
    return list;
  }
}
```
