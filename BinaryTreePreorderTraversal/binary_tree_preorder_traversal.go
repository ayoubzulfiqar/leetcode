package main

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

/*

Runtime: 0 ms, faster than 100.00% of Go online submissions for Binary Tree Preorder Traversal.
Memory Usage: 2.1 MB, less than 40.85% of Go online submissions for Binary Tree Preorder Traversal.

*/

func preorderTraversal(root *TreeNode) []int {
	var res []int
	helper(root, &res)
	return res
}

func helper(root *TreeNode, res *[]int) {
	if root == nil {
		return
	}
	*res = append(*res, root.Val)
	helper(root.Left, res)
	helper(root.Right, res)
}
