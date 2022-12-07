package main

// Definition for a binary tree node.
type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

// func rangeSumBST(root *TreeNode, low int, high int) int {
// 	if root == nil {
// 		return 0
// 	}
// 	if root.Val < low {
// 		return rangeSumBST(root.Right, low, high)
// 	}
// 	if root.Val > high {
// 		return rangeSumBST(root.Left, low, high)
// 	}
// 	return root.Val + rangeSumBST(root.Right, low, high) + rangeSumBST(root.Left, low, high)
// }

func rangeSumBST(root *TreeNode, low int, high int) int {
	var stack []TreeNode
	stack = append(stack, *root)
	var sum int = 0
	for len(stack) != 0 {
		var node *TreeNode = &stack[len(stack)-1]
		if node == nil {
			continue
		}
		if node.Val > low {
			stack = append(stack, *node.Left)
		}
		if node.Val < high {
			stack = append(stack, *node.Right)
		}
		if low <= node.Val && node.Val <= high {
			sum += node.Val
		}
	}
	return sum
}

/*

 int rangeSumBST(TreeNode? root, int low, int high) {
    List<TreeNode?> stk = [];
    stk.add(root);
    int sum = 0;
    while (stk.isNotEmpty) {
      TreeNode? n = stk.removeLast();
      if (n == null) {
        continue;
      }
      if (n.val > low) {
        stk.add(n.left);
      } // left child is a possible candidate.
      if (n.val < high) {
        stk.add(n.right);
      } // right child is a possible candidate.
      if (low <= n.val && n.val <= high) {
        sum += n.val;
      }
    }
    return sum;
  }

*/
