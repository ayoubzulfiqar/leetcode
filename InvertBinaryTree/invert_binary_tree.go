package main

// Definition for a binary tree node.
type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func invertTree(root *TreeNode) *TreeNode {
	stack := []*TreeNode{root}

	for len(stack) != 0 {
		pop := stack[len(stack)-1]
		stack = stack[:len(stack)-1]

		if pop != nil {
			pop.Right, pop.Left = pop.Left, pop.Right
			stack = append(stack, pop.Right, pop.Left)
		}

	}

	return root
}
