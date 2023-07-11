/*


-* 863. All Nodes Distance K in Binary Tree *-

Given the root of a binary tree, the value of a target node target, and an integer k, return an array of the values of all nodes that have a distance k from the target node.

You can return the answer in any order.

 

Example 1:


Input: root = [3,5,1,6,2,0,8,null,null,7,4], target = 5, k = 2
Output: [7,4,1]
Explanation: The nodes that are a distance 2 from the target node (with value 5) have values 7, 4, and 1.
Example 2:

Input: root = [1], target = 1, k = 3
Output: []
 

Constraints:

The number of nodes in the tree is in the range [1, 500].
0 <= Node.val <= 500
All the values Node.val are unique.
target is the value of one of the nodes in the tree.
0 <= k <= 1000

*/

import 'dart:collection';

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

class Solution {
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

  List<int> distanceK(TreeNode? root, TreeNode? target, int k) {
    final HashMap<TreeNode?, TreeNode?> parent = HashMap();

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
