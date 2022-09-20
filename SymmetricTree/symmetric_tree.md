# ️‍🔥️ DART ️‍🔥 ||  FASTEST AND EASIEST || Recursive && Iterative

## Definition for a binary tree node

```dart
class TreeNode {
  int val;
  TreeNode? left;
  TreeNode? right;
  TreeNode([this.val = 0, this.left, this.right]);
}
```

## Solution - 1 Recursive

```dart
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
```

## Solution - 2 Iterative

```dart
import 'dart:collection';

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
```

## Bonus Solution - Golang := Recursive && Iterative

### Recursive

```go
package main

// Definition for a binary tree node.
type TreeNode struct {
 Val   int
 Left  *TreeNode
 Right *TreeNode
}

var answer bool

func isSymmetric(root *TreeNode) bool {
 answer = true
 if root != nil {
  findSymmetricity(root.Left, root.Right)
 }
 return answer
}

func findSymmetricity(firstNode, secondNode *TreeNode) {
 if firstNode == nil && secondNode == nil || answer == false {
  return
 }
 if firstNode == nil || secondNode == nil || firstNode.Val != secondNode.Val {
  answer = false
  return
 }
 findSymmetricity(firstNode.Left, secondNode.Right)
 findSymmetricity(firstNode.Right, secondNode.Left)
}

```

### Iterative

```go
func isSymmetric(root *TreeNode) bool {

 //  Runtime: 0 ms, faster than 100.00% of Go online submissions for Symmetric Tree.
 // Memory Usage: 2.9 MB, less than 19.79% of Go online submissions for Symmetric Tree.
 if root == nil {
  return true
 }

 stack := make([]*TreeNode, 2)
 stack[0] = root
 stack[1] = root

 for len(stack) > 0 {
  n := len(stack) - 1
  firstNode := stack[n]
  stack = stack[:n]

  n = len(stack) - 1
  secondNode := stack[n]
  stack = stack[:n]

  if firstNode == nil && secondNode == nil {
   continue
  }

  if firstNode == nil || secondNode == nil {
   return false
  }

  if firstNode.Val != secondNode.Val {
   return false
  }

  stack = append(stack, firstNode.Left)
  stack = append(stack, secondNode.Right)
  stack = append(stack, firstNode.Right)
  stack = append(stack, secondNode.Left)
 }

 return true
}

```
