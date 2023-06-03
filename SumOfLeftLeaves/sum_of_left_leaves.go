package main

// Definition for a binary tree node.
type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func sumOfLeftLeaves(root *TreeNode) int {
	ans := 0
	for root != nil {
		if root.Left != nil {
			pre := root.Left
			for pre.Right != nil && pre.Right != root {
				pre = pre.Right
			}

			if pre.Right == nil {
				pre.Right = root
				root = root.Left
			} else {
				pre.Right = nil

				if pre == root.Left && pre.Left == nil {
					ans += pre.Val
				}
				root = root.Right
			}
		} else {
			root = root.Right
		}
	}
	return ans
}
