/*

  -* Same Tree *-

Given the roots of two binary trees p and q, write a function to check if they are the same or not.

Two binary trees are considered the same if they are structurally identical, and the nodes have the same value.



Example 1:


Input: p = [1,2,3], q = [1,2,3]
Output: true


Example 2:


Input: p = [1,2], q = [1,null,2]
Output: false


Example 3:


Input: p = [1,2,1], q = [1,1,2]
Output: false


Constraints:

The number of nodes in both trees is in the range [0, 100].
-104 <= Node.val <= 104

*/
import 'dart:collection';

// Definition for a binary tree node.
class TreeNode {
  int val;
  TreeNode? left;
  TreeNode? right;
  TreeNode([this.val = 0, this.left, this.right]);
}

class A {
// Runtime: 388 ms, faster than 54.55% of Dart online submissions for Same Tree.
// Memory Usage: 142.4 MB, less than 81.82% of Dart online submissions for Same Tree.
  bool isSameTree(TreeNode? p, TreeNode? q) {
    if (p == null && q == null) return true;
    if (p != null && q == null || p == null && q != null || p?.val != q?.val)
      return false;
    return isSameTree(p?.left, q?.left) && isSameTree(p?.right, q?.right);
  }
}

extension MinimalistStack<E> on Queue<E> {
  void push(E value) => addLast(value);
  E pop() => removeLast();
}

class B {
// 60 / 60 test cases passed, but took too long.
// Status: Time Limit Exceeded
// Submitted: 0 minutes ago
  bool isSameTree(TreeNode? p, TreeNode? q) {
    final stackA = DoubleLinkedQueue<TreeNode?>()..add(p);
    final stackB = DoubleLinkedQueue<TreeNode?>()..add(q);

    while (stackA.isNotEmpty || stackB.isNotEmpty) {
      p = stackA.pop();
      q = stackB.pop();
      if (p == null && q == null) continue;
      if (p == null && q != null || p != null && q == null) return false;
      if (p!.val != q!.val) return false;
      stackA
        ..push(p.left)
        ..push(p.right);
      stackB
        ..push(q.left)
        ..push(q.right);
    }
    return stackA.isEmpty == stackB.isEmpty;
  }
}

class C {
//   Runtime: 472 ms, faster than 27.27% of Dart online submissions for Same Tree.
// Memory Usage: 142.7 MB, less than 54.55% of Dart online submissions for Same Tree
  bool isSameTree(TreeNode? p, TreeNode? q) {
    if (p != null && q != null)
      return p.val == q.val &&
          isSameTree(p.left, q.left) &&
          isSameTree(p.right, q.right);
    else
      return p == q;
  }
}
