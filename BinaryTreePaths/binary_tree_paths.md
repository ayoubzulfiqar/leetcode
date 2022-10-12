# 🔥 Binary Tree Paths 🔥 || 3 Solutions || Simple Fast and Easy || with Explanation

## Time Complexity Analysis

### Case Study

First let's work on the balanced tree situation:

- It should be obvious to see now that each node will contribute to the total time cost an amount of length of the path from the root to this node. The problem is to see how to sum up these paths' lengths for N nodes altogether.

- Denote the time complexity for N nodes as T(N).

Suppose we do have that balanced tree now (and also N is 2^N-1 for simplicity of discussion). Amd we know that N/2 nodes lie at the leaf/deepest level of the BST since it's balanced binary tree.

We easily have this recurrence formula:
T(N) = T(N/2) + (N/2) * lgN

- Which means, we have N nodes, with half lying on the deepest (the lgNth) level. The sum of path lengths for N nodes equals to sum of path lengths for all nodes except those on the lgN-th level plus the sum of path lengths for those nodes on the lgN-th level.

- This recurrence is not hard to solve. I did not try to work out the exact solution since the discussion above in itself are in essence a little blurry on corner cases, but it is easy to discover that T(N) = O(NlgN).

### To Generalize: Let's Start with Worst-Case

- The problem left here now, is a balanced tree the best-case or the worst-case? I was convinced it was the worst case before I doodled some tree up and found otherwise.

- The worst case is actually when all nodes lie up to a single line like a linked list, and the complexity in this case is easily calculable as O(N^2). But how do we prove that?

the proof is easier than you think. Just use induction. Suppose we have N - 1 nodes in a line, and by inductive hypothesis we claim that this tree is the max-path-sum tree for N-1 nodes. We just have to prove that the max-path-sum tree for N nodes is also a single line. How do you prove it? Well suppose that you see the N-1-node line here, and you want to add the N-th node, where would you put it? Of course the deepest level so that the new node gets maximum depth.

### Best-Case

Proving that the best case is the balanced tree can be a little trickier. By some definition, A tree where no leaf is much farther away from the root than any other leaf. Suppose we define much farther as like 2 steps farther.
Then for the purpose of contradiction, suppose the min-path-sum tree for N nodes is not balanced, then there is a leaf A that is at least 2 steps further to the root than another leaf B. Then we can always move A to be the direct descendant of B (since B is leaf, there is an opening) resulting in a tree with smaller sum of paths. Thus the contradiction.
This proof is a little informal, but I hope the idea is clear.

### Conclusion: Upper and Lower Bounds

In conclusion, the complexity of this program is Ω(NlgN) ~ O(N^2).

Optimization: How About Mutability
I do think that the main cost incurred in this algorithm is a result of the immutability of String and the consequent allocation and copying.
Intuitively, it seems like that StringBuilder could help. Using StringBuilder, we could make sure that String allocation and copying only happens when we are at a leaf. That means, the cost would be now sum of length of all root-to-leaf paths rather than sum of length of all root-to-node paths. This is assuming that StringBuilder.append and StringBuilder.setLength can work in O(1) or at least less than O(N) time.

## Definition for a binary tree node

```dart
class TreeNode {
  int val;
  TreeNode? left;
  TreeNode? right;
  TreeNode([this.val = 0, this.left, this.right]);
}
```

## Solution - 1

```dart

class Solution {
// Runtime: 466 ms, faster than 50.00% of Dart online submissions for Binary Tree Paths.
// Memory Usage: 142.6 MB, less than 50.00% of Dart online submissions for Binary Tree Paths.
  List<String> binaryTreePaths(TreeNode? root) {
    List<String> res = [];
    if (root == null) return res;
    dfs(root, res, "");
    return res;
  }

  void dfs(TreeNode? root, List ls, String str) {
    if (root == null) return;
    str += (str.length == 0 ? "" : "->") + root.val.toString();
    if (root.left == null && root.right == null) {
      ls.add(str);
      return;
    }
    dfs(root.left, ls, str);
    dfs(root.right, ls, str);
  }
}
```

## Solution - 2

```dart
class Solution {
// wrong
  List binaryTreePaths(TreeNode? root) {
    List<String> res = [];
    StringBuffer sb = StringBuffer();
    if (root == null) return res;
    dfs(root, res, sb);
    return res;
  }

  void dfs(TreeNode? root, List ls, StringBuffer str) {
    if (root == null) return;
    str.write((str.length == 0 ? "" : "->") + root.val.toString());
    if (root.left == null && root.right == null) {
      ls.add(str.toString());
      return;
    }
    dfs(root.left, ls, str);
    str.length;
    dfs(root.right, ls, str);
    str.length;
  }
}
```

## Solution - 3 - Golang

```go
import (
	"strconv"
	"strings"
)
// Definition for a binary tree node.
type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

type nodePath struct {
	node     *TreeNode
	prevPath []int
}

func binaryTreePaths(root *TreeNode) []string {
	res := make([]string, 0)

	stack := make([]nodePath, 0)
	stack = append(stack, nodePath{root, []int{}})

	var sb strings.Builder
	for len(stack) > 0 {
		cur := stack[len(stack)-1]
		stack = stack[:len(stack)-1]

		if cur.node.Left == nil && cur.node.Right == nil {
			for _, n := range cur.prevPath {
				sb.WriteString(strconv.Itoa(n))
				sb.WriteString("->")
			}
			sb.WriteString(strconv.Itoa(cur.node.Val))
			res = append(res, sb.String())
			sb.Reset()
		}

		if cur.node.Left != nil {
			stack = append(stack, nodePath{cur.node.Left, append(cur.prevPath, cur.node.Val)})
		}
		if cur.node.Right != nil {
			stack = append(stack, nodePath{cur.node.Right, append(cur.prevPath, cur.node.Val)})
		}
	}

	return res
}
```
