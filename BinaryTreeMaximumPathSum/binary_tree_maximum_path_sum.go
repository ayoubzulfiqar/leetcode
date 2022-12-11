package main

// Definition for a binary tree node.
type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func max(a int, b int) int {
	if a > b {
		return a
	}
	return b
}
func min(a int, b int) int {
	if a < b {
		return a
	}
	return b
}

// ==================== 1
func maxPathSum(root *TreeNode) int {
	var maxi []int = make([]int, 1)
	maxi[0] = -1000
	pathDown(maxi, root)
	return maxi[0]
}

func pathDown(maxi []int, root *TreeNode) int {
	if root == nil {
		return 0
	}
	var leftMax int = max(0, pathDown(maxi, root.Left))
	var rightMax int = max(0, pathDown(maxi, root.Right))
	maxi[0] = max(maxi[0], root.Val+leftMax+rightMax)
	return root.Val + max(leftMax, rightMax)
}

// ==================================  2

// var val int = -1000

// func maxPathSum(root *TreeNode) int {
// 	postOrder(root)
// 	return val
// }

// func postOrder(root *TreeNode) int {
// 	if root == nil {
// 		return 0
// 	}
// 	var sumLeft int = postOrder(root.Left)
// 	var sumRight int = postOrder(root.Right)
// 	var maxi int = max(root.Val, max(root.Val+sumLeft, max(root.Val+sumRight, root.Val+sumRight+sumLeft)))
// 	if maxi > val {
// 		val = maxi
// 	}
// 	// var value int = root.Val + max(sumLeft, sumRight)
// 	if root.Val > root.Val+max(sumLeft, sumRight) {
// 		return root.Val
// 	} else {
// 		return root.Val + max(sumLeft, sumRight)
// 	}

// }
