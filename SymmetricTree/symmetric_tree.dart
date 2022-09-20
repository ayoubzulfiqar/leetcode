/*


 -* Symmetric Tree  *-


Given the root of a binary tree, check whether it is a mirror of itself (i.e., symmetric around its center).



Example 1:


Input: root = [1,2,2,3,4,4,3]
Output: true
Example 2:


Input: root = [1,2,2,null,3,null,3]
Output: false


Constraints:

The number of nodes in the tree is in the range [1, 1000].
-100 <= Node.val <= 100


Follow up: Could you solve it both recursively and iteratively?

*/
import 'dart:collection';

// Definition for a binary tree node.
class TreeNode {
  int val;
  TreeNode? left;
  TreeNode? right;
  TreeNode([this.val = 0, this.left, this.right]);
}

class Recursive {
// With - ? Operator
// Runtime: 501 ms, faster than 37.50% of Dart online submissions for Symmetric Tree.
// Memory Usage: 142.1 MB, less than 93.75% of Dart online submissions for Symmetric Tree.

//  With - ! Operator
//  Runtime: 532 ms, faster than 25.00% of Dart online submissions for Symmetric Tree.
//  Memory Usage: 141.9 MB, less than 93.75% of Dart online submissions for Symmetric Tree.
  bool findSymmetricity(TreeNode? firstNode, TreeNode? secondNode) {
    if (firstNode == null && secondNode == null) return true;
    if (firstNode != null && secondNode == null ||
        firstNode == null && secondNode != null ||
        firstNode?.val != secondNode?.val) return false;
    return findSymmetricity(firstNode?.left, secondNode?.right) &&
        findSymmetricity(firstNode?.right, secondNode?.left);
  }

  bool isSymmetric(TreeNode? root) {
    return findSymmetricity(root, root);
  }
}

// Iterative(Using BFS Technique)
// class Iterative {
//   bool isSymmetric(TreeNode? root) {
//     if (root == null) return true;
//     Queue<TreeNode?> queue = Queue<TreeNode?>();
//     // addLast is push
//     queue.addLast(root);
//     int l = 1;
//     while (queue.isNotEmpty) {
//       int queueSize = queue.length;
//       int sizeValue = 2 * queueSize;
//       List<int> value = [sizeValue];
//       int cntNull = 0;
//       for (int i = 0; i < queueSize; i++) {
//         // queue.front
//         TreeNode? node = queue.first;
//         queue.removeLast();
//         if (node?.left != null) {
//           value[i] = node?.left?.val as int;
//           queue.addLast(node?.left);
//         } else {
//           value[i] = -200;
//           cntNull++;
//         }
//         if (node?.right != null) {
//           value[i + queueSize] = node?.right?.val as int;
//           queue.addLast(node?.right);
//         } else {
//           value[i + queueSize] = -200;
//           cntNull++;
//         }
//       }
//       if (cntNull == sizeValue) break;
//       for (int i = 0; i < (sizeValue / 2); i++) {
//         if (value[i] != value[sizeValue - i - 1]) {
//           return false;
//         }
//       }
//       value.remove([]);
//     }
//     return true;
//   }
// }

// class C {
//   bool isSymmetric(TreeNode? root) {
//     if (root == null) return false;
//     Queue<TreeNode?> q = Queue<TreeNode?>();
//     q.add(root);
//     while (q.isNotEmpty) {
//       int count = q.length;
//       List<int> arr = [];
//       for (int i = 0; i < count; ++i) {
//         TreeNode? currNode = q.removeLast();
//         if (currNode == null)
//           arr.add(200);
//         else
//           arr.add(currNode.val);
//         if (currNode?.left == null)
//           q.add(null);
//         else if (currNode?.left != null) q.add(currNode?.left);

//         if (currNode?.right == null)
//           q.add(null);
//         else if (currNode?.right != null) q.add(currNode?.right);
//       }
//       int i = 0, j = arr.length - 1;
//       //comparing palindrome
//       //if the all the values are 200 -> leaf condition
//       while (i <= j) {
//         if (arr.elementAt(i) == 200 && arr.elementAt(j) == 200) {
//           i++;
//           j--;
//           continue;
//         }
//         if (arr.elementAt(i) != arr.elementAt(j)) {
//           return false;
//         }
//         i++;
//         j--;
//       }
//     }
//     return true;
//   }
// }

// class D {
//   bool isSymmetric(TreeNode? root) {
//     List<TreeNode?> nodesToTraverse = [root];

//     while (nodesToTraverse.length != 0) {
//       List level = [];
//       List symmetryStack = [];
//       int childrenCount = nodesToTraverse.length;

//       for (int i = 0; i < childrenCount; i++) {
//         TreeNode? node = nodesToTraverse.removeAt(0);

//         if (i < childrenCount / 2) {
//           symmetryStack.add(node?.val);
//         } else {
//           if (symmetryStack[symmetryStack.length - 1] != node?.val) {
//             return false;
//           } else {
//             symmetryStack.removeLast();
//           }
//         }

//         if (node != null) {
//           continue;
//         }

//         level.add(node?.left);
//         level.add(node?.right);
//       }

//       nodesToTraverse.add(level);
//     }

//     return true;
//   }
// }

class Iterative {
//  Runtime: 529 ms, faster than 31.25% of Dart online submissions for Symmetric Tree.
//  Memory Usage: 144.7 MB, less than 12.50% of Dart online submissions for Symmetric Tree.
  bool isSymmetric(TreeNode? root) {
    if (root == null) return true;
    Queue<TreeNode?> queue = Queue<TreeNode?>();
    queue.add(root.left);
    queue.add(root.right);
    while (queue.isNotEmpty) {
      TreeNode? firstNode = queue.removeFirst();
      TreeNode? secondNode = queue.removeFirst();
      if (firstNode == null && secondNode == null) continue;
      if (firstNode == null ||
          secondNode == null ||
          secondNode.val != secondNode.val) return false;
      queue.add(firstNode.left);
      queue.add(secondNode.right);
      queue.add(firstNode.right);
      queue.add(secondNode.left);
    }
    return true;
  }
}
