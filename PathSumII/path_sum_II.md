# 🔥 Dart 🔥 || 4 solutions || line by line explanation

## Solution - 1

```dart
class Solution {
  // global empty list - if i just use [] than it will end up with range error
  // so this is most efficient way to create growable empty list
  List<List<int>> result = List.empty(growable: true)
      .map((e) => List<int>.empty(growable: true))
      .toList();
  List<List<int>> pathSum(TreeNode? root, int targetSum) {
    List<int> path = [];
    dfs(root, path, targetSum);
    return result;
  }

  void dfs(TreeNode? node, List<int> path, int remainingSum) {
    // if it is null, then return
    if (node == null) return;
    // add the current node val to path
    path.add(node.val);
    // !node.left && !node.right : check if it is a leaf node
    // remainingSum == node.val: check if the remaining sum - node.val == 0
    // if both condition is true, then we find one of the paths
    if (node.left == null && node.right == null && remainingSum == node.val) {
      result.add(List.of(path, growable: true));
    }
    // traverse left sub tree with updated remaining sum
    // we don't need to check if left sub tree is null or not
    // as we handle it in the first line of this function
    this.dfs(node.left, path, remainingSum - node.val);
    // traverse right sub tree with updated remaining sum
    // we don't need to check if right sub tree is null or not
    // as we handle it in the first line of this function
    this.dfs(node.right, path, remainingSum - node.val);
    // backtrack
    path.remove(path.length - 1);
  }
}
```

## Solution - 2 PreOrder DFS - dfs pre-order traversal

```dart
class Solution {
// Runtime: 508 ms, faster than 100.00% of Dart online submissions for Path Sum II.
// Memory Usage: 143.6 MB, less than 83.33% of Dart online submissions for Path Sum II.
  List<List<int>> pathSum(TreeNode? root, int targetSum) {
    // edge case
    if (root == null) return [];
    // empty growable list
    List<List<int>> result = List.empty(growable: true)
        .map((e) => List<int>.empty(growable: true))
        .toList();
    // list that will hold the node value
    List<int> visited = [];
    void traverse(TreeNode? node) {
      visited.add(node!.val);
      // life the both side of the node tree is null
      if (node.left == null && node.right == null) {
        // than our leaf value will be node value an reduce operator to do the sum of all values
        int leafSum = [...visited].reduce((a, b) => a + b);
        // if the sum same as our targetSum than we will ad the value in to visited list
        if (leafSum == targetSum) result.add([...visited]);
      }
      // if the left side of node have value we will retrieve the left value from root tree
      if (node.left != null) traverse(node.left);
      // if the right side of node have value we will retrieve the right value from root tree
      if (node.right != null) traverse(node.right);

      visited.removeLast();
    }

    // than we wil get the whole root
    traverse(root);

    return result;
  }
}
```

## SOlution - 3 Recursive

```dart
class Solution {
// Runtime: 506 ms, faster than 100.00% of Dart online submissions for Path Sum II.
// Memory Usage: 154.4 MB, less than 50.00% of Dart online submissions for Path Sum II.
  List<List<int>> pathSum(TreeNode? root, int targetSum) {
    List<List<int>> paths = List.empty(growable: true)
        .map((e) => List<int>.empty(growable: true))
        .toList();

    void dfs(root, sum, [List<int> current = const []]) {
      if (root == null) return;

      List<int> newCurrent = [...current, root.val];
      if (root.left == null && root.right == null && sum == root.val)
        return paths.add(newCurrent);

      dfs(root.left, sum - root.val, newCurrent);
      dfs(root.right, sum - root.val, newCurrent);
    }

    dfs(root, targetSum);
    return paths;
  }
}
```

## Solution - 4 Stack (QUEUE)

```dart
class Solution {
// Runtime: 557 ms, faster than 33.33% of Dart online submissions for Path Sum II.
// Memory Usage: 149.7 MB, less than 50.00% of Dart online submissions for Path Sum II.
  List<List<int>> pathSum(TreeNode? root, int targetSum) {
    List<List<int>> res = List.empty(growable: true)
        .map((e) => List<int>.empty(growable: true))
        .toList();
    if (root == null) return res;

    Queue<TreeNode?> nodeStack = Queue();
    Queue<int> sumStack = Queue();
    Queue<List<int>> pathStack = Queue();
    List<int> path = [];
    nodeStack.add(root);
    sumStack.add(root.val);
    path.add(root.val);
    pathStack.add(path);
    while (nodeStack.isNotEmpty) {
      TreeNode? node = nodeStack.removeLast();
      int tmp = sumStack.removeLast();
      path = pathStack.removeLast();
      if (node!.left == null && node.right == null) {
        if (tmp == targetSum) {
          res.add(path);
        }
      }

      if (node.right != null) {
        nodeStack.add(node.right);
        sumStack.add(tmp + node.right!.val);
      }
      // avoid interfere left side which also uses the popped path
      List<int> pathCopy = [...path];
      pathCopy.add(node.right!.val);
      pathStack.add(pathCopy);

      if (node.left != null) {
        nodeStack.add(node.left);
        sumStack.add(tmp + node.left!.val);
        path.add(node.left!.val);
        pathStack.add(path);
      }
    }
    return res;
  }
}
```

## Bonus Solution - Golang

```go
func pathSum(root *TreeNode, targetSum int) [][]int {

    return walkTree(root, nil, 0, targetSum)

}

func walkTree(t *TreeNode, node []int, sum int, target int) [][]int {
    if t == nil {
        return nil
    }
    var ans [][]int
    if t.Left == nil && t.Right == nil {
        if sum + t.Val == target {
            res := make([]int, len(node) + 1)
            copy(res, append(node, t.Val))
            ans = append(ans, res)
            return ans
        } else {
            return nil
        }
    }

    node = append(node, t.Val)

    if t.Left != nil {
        res := walkTree(t.Left, node, sum + t.Val, target)
        if res != nil {
            ans = append(ans, res...)
        }
    }

    if t.Right != nil {
        res := walkTree(t.Right,  node, sum + t.Val, target)
        if res != nil {
            ans = append(ans, res...)
        }
    }
    return ans
}
```

### [GitHub Link](https://github.com/ayoubzulfiqar/leetcode)
