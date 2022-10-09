package main

// Definition for a binary tree node.
type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func findTarget(root *TreeNode, k int) bool {
	visited := map[int]bool{}
	var preorder func(*TreeNode) bool
	preorder = func(node *TreeNode) bool {
		if node == nil {
			return false
		}
		if visited[k-node.Val] {
			return true
		}
		visited[node.Val] = true
		if preorder(node.Left) {
			return true
		}
		if preorder(node.Right) {
			return true
		}
		return false
	}
	return preorder(root)
}
