# 🔥 DFS + BFS 🔥 || Simple Fast and Easy || with Explanation 😈

## Solution - 1

### Intuition

As the name indicates level order traversal is traversing the tree level by level.This can easily achieved with the use of a queue.
But there is an additional requirement that the sum of each level and the level itself has to be remembered. This can be achieved with slight modification to L.O.T i.e we get the size of the queue at the beginning of each loop and traverse all the elements in a for loop.

### Approach

1. Initialize a queue and add the root.

2. Initialize maxSum, ans and level.

while queue is not empty:
4. Get the size of queue and store in levelSize.

for i = 0 to level size remove all the elements from queue and add it to levelSum.
if levelSum> maxSum change both maxSum and ans.
level++
5. Return ans.

```dart
import 'dart:collection';

class TreeNode {
  int val;
  TreeNode? left;
  TreeNode? right;
  TreeNode([this.val = 0, this.left, this.right]);
}

class Solution {
  int maxLevelSum(TreeNode? root) {
    final Queue<TreeNode?> queue = Queue();
    queue.add(root);
    int maxSum = root!.val;
    int ans = 1;
    int level = 1;
    while (queue.isNotEmpty) {
      final int levelSize = queue.length;
      int levelSum = 0;
      for (int i = 0; i < levelSize; i++) {
        final TreeNode? removed = queue.removeFirst();
        levelSum += removed!.val;
        if (removed.left != null) queue.add(removed.left);
        if (removed.right != null) queue.add(removed.right);
      }
      if (levelSum > maxSum) {
        maxSum = levelSum;
        ans = level;
      }
      level++;
    }
    return ans;
  }
}
```

## Solution - 2

```dart
class Solution {
  List<int> levelSums;
  int height;

  Solution()
      : levelSums = List<int>.filled(100, 0),
        height = 1;

  int maxLevelSum(TreeNode? root) {
    dfs(root, 1);

    int maxSumLevel = 1;
    for (int level = 2; level <= height; ++level) {
      if (levelSums[maxSumLevel] < levelSums[level]) {
        maxSumLevel = level;
      }
    }

    return maxSumLevel;
  }

  void dfs(TreeNode? root, int level) {
    if (root == null) {
      return;
    }

    height = level > height ? level : height;
    ensureCapacity();

    levelSums[level] += root.val;

    dfs(root.left, level + 1);
    dfs(root.right, level + 1);
  }

  void ensureCapacity() {
    if (height == levelSums.length) {
      levelSums = List<int>.from(levelSums)..length = height << 1;
    }
  }
}
```
