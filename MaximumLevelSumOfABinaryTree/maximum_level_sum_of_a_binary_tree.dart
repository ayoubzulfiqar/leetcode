/*


-* 1161. Maximum Level Sum of a Binary Tree *-


Given the root of a binary tree, the level of its root is 1, the level of its children is 2, and so on.

Return the smallest level x such that the sum of all the values of nodes at level x is maximal.

 

Example 1:


Input: root = [1,7,0,7,-8,null,null]
Output: 2
Explanation: 
Level 1 sum = 1.
Level 2 sum = 7 + 0 = 7.
Level 3 sum = 7 + -8 = -1.
So we return the level with the maximum sum which is level 2.
Example 2:

Input: root = [989,null,10250,98693,-89388,null,null,null,-32127]
Output: 2
 

Constraints:

The number of nodes in the tree is in the range [1, 104].
-105 <= Node.val <= 105




*/
import 'dart:collection';

class TreeNode {
  int val;
  TreeNode? left;
  TreeNode? right;
  TreeNode([this.val = 0, this.left, this.right]);
}

class A {
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
