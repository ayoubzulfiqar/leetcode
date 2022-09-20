# 🔥 Dart 🔥 || Simple Solution 100% faster || line by line explanation

## Definition of TreeNode

```dart
class TreeNode {
  int val;
  TreeNode? left;
  TreeNode? right;
  TreeNode([this.val = 0, this.left, this.right]);
}
```

## SOlution - 1 Time complexity: O(n), Space complexity: O(h), h is Tree Height

```dart
class Solution {
// Runtime: 854 ms, faster than 20.00% of Dart online submissions for Minimum Depth of Binary Tree.
// Memory Usage: 184.5 MB, less than 60.00% of Dart online submissions for Minimum Depth of Binary Tree.
  int minDepth(TreeNode? root) {
    if (root == null) return 0;
    int left = minDepth(root.left);
    int right = minDepth(root.right);
    //if both left and right 0, that means there is no path in left and right
    // return 1 as current node in the current path
    if (left == 0 && right == 0)
      return 1;
    // if left is 0 and right has some value, that means there is no path in left side
    //but some path in right side, so return whatever value + 1, the extra 1 is for current node
    else if (left == 0)
      return right + 1;
    // if right is 0 and left has some value, that means there is no path in right side
    //but some path in left side, so return whatever value + 1, the extra 1 is for current node
    else if (right == 0)
      return left + 1;
    // if in both side path exist, then consider the minimum and add 1 for the current node
    else
      return min(left, right) + 1;
  }
}
```

## Solution - 2

```dart
class Solution {
// 52 / 52 test cases passed, but took too long.
// Status: Time Limit Exceeded
// Submitted: 0 minutes ago

  int minDepth(TreeNode? root) {
    if (root == null) return 0;
    if (root.left == null && root.right == null) return 1;
    int leftDepth =
        root.left != null ? minDepth(root.left) : double.maxFinite.floor();
    int rightDepth =
        root.right != null ? minDepth(root.right) : double.maxFinite.floor();
    return 1 + min(leftDepth, rightDepth);
  }
}
```

## Solution  - 3

```dart
class Solution {
// Runtime: 687 ms, faster than 20.00% of Dart online submissions for Minimum Depth of Binary Tree.
// Memory Usage: 184.3 MB, less than 80.00% of Dart online submissions for Minimum Depth of Binary Tree.
  int minDepth(TreeNode? root) {
    if (root == null) return 0;

    // Base case
    if (root.left == null && root.right == null) return 1;

    // If left subtree is NULL, recursion for right subtree
    if (root.left == null) return minDepth(root.right) + 1;

    // If right subtree is NULL, recursion for left subtree
    if (root.right == null) return minDepth(root.left) + 1;

    return min(minDepth(root.left), minDepth(root.right)) + 1;
  }
}
```

## Bonus - Golang Solution

```go
func minDepth(root *TreeNode) int {
    if root == nil {
        return 0
    }
    var currentDepth int = 1

    queue := NewTreeNodeQueue()
    queue.Enqueue(root)

    for !queue.IsEmpty() {
        level := queue.Size()

        for i := 0; i < level; i++ {
            node := queue.Dequeue()
            if !HasChildren(node) {
                return currentDepth
            }
            queue.EnqueueChildren(node)
        }

        currentDepth++
    }
    return currentDepth
}

func HasChildren(node *TreeNode) bool {
    return node.Left != nil || node.Right != nil
}

type TreeNodeQueue struct {
    items []*TreeNode
}

func NewTreeNodeQueue() *TreeNodeQueue {
    return &TreeNodeQueue{
        items: make([]*TreeNode, 0),
    }
}

func (q *TreeNodeQueue) EnqueueChildren(n *TreeNode) {
    if n.Left != nil {
        q.Enqueue(n.Left)
    }
    if n.Right != nil {
        q.Enqueue(n.Right)
    }
}

func (q *TreeNodeQueue) Enqueue(n *TreeNode) {
    q.items = append(q.items, n)
}

func (q *TreeNodeQueue) Dequeue() *TreeNode {
    if q.IsEmpty() {
        return nil
    }

    n := q.items[0]
    q.items = q.items[1:]
    return n
}

func (q *TreeNodeQueue) Size() int {
    return len(q.items)
}

func (q *TreeNodeQueue) IsEmpty() bool {
    return q.Size() == 0
}

```
