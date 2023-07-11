# 🔥 DFS + BFS 🔥 || Simple Fast and Easy || with Explanation 😈

## Disclaimer

## Tree Definition

```dart
class TreeNode {
  late int val;
  TreeNode? left;
  TreeNode? right;

  TreeNode(int val) {
    this.val = val;
    left = null;
    right = null;
  }
}
```

## BFS

```dart
  void getParentByBFS(Map<TreeNode?, TreeNode?> parent, TreeNode? root) {
    final Queue<TreeNode?> q = Queue<TreeNode?>();
    q.add(root);
    while (q.isNotEmpty) {
      int n = q.length;
      while (n > 0) {
        final TreeNode? current = q.removeFirst();
        if (current!.left != null) {
          parent[current.left] = current;
          q.add(current.left);
        }
        if (current.right != null) {
          parent[current.right] = current;
          q.add(current.right);
        }
        n--;
      }
    }
  }
```

## DFS

```dart
  void getParentByDFS(Map<TreeNode?, TreeNode?> parent, TreeNode? root) {
    if (root == null) return;
    if (root.left != null) {
      parent[root.left] = root;
    }
    if (root.right != null) {
      parent[root.right] = root;
    }
    getParentByDFS(parent, root.left);
    getParentByDFS(parent, root.right);
  }
```

### Solution

```dart
import 'dart:collection';
class Solution {
  List<int> distanceK(TreeNode? root, TreeNode? target, int k) {
    final HashMap<TreeNode?, TreeNode?> parent = HashMap();

  /* Call One of them here: Don't be stupid to Call Both of them */

    // getParentByDFS(parent, root); 

    // getParentByBFS(parent, root);
    
    final Queue<TreeNode?> q = Queue<TreeNode?>();
    final HashMap<TreeNode?, bool> visited = HashMap();
    visited[target] = true;
    q.add(target);
    int lev = 0;
    while (q.isNotEmpty) {
      int n = q.length;
      if (lev == k) break;
      lev++;
      while (n > 0) {
        final TreeNode? current = q.removeFirst();
        if (current!.left != null && !visited[current.left]!) {
          visited[current.left] = true;
          q.add(current.left);
        }
        if (current.right != null && !visited[current.right]!) {
          visited[current.right] = true;
          q.add(current.right);
        }
        if (parent[current] != null && !visited[parent[current]]!) {
          visited[parent[current]] = true;
          q.add(parent[current]);
        }
        n--;
      }
    }
    List<int> answer = [];
    while (q.isNotEmpty) {
      answer.add(q.first!.val);
      q.removeFirst();
    }
    return answer;
  }
}
```
