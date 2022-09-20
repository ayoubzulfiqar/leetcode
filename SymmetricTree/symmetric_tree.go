package main

// Definition for a binary tree node.
type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

var answer bool

// Recursive
func isSymmetrics(root *TreeNode) bool {

	// 	Runtime: 3 ms, faster than 70.37% of Go online submissions for Symmetric Tree.
	// Memory Usage: 2.9 MB, less than 83.92% of Go online submissions for Symmetric Tree.
	var answer bool = true
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

func isSymmetric(root *TreeNode) bool {

	// 	Runtime: 0 ms, faster than 100.00% of Go online submissions for Symmetric Tree.
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
		// rewrite
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
