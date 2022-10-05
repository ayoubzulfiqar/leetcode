package main

// Definition for a binary tree node.
type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func addOneRow(root *TreeNode, val int, depth int) *TreeNode {
	if depth == 1 {
		return &TreeNode{
			Val:   val,
			Left:  root,
			Right: nil,
		}
	}

	var queue []*TreeNode
	queue = append(queue, root)

	currentDepth := 1

	for len(queue) > 0 {
		currentDepth++
		length := len(queue)

		for i := 0; i < length; i++ {
			if currentDepth == depth {
				left := queue[i].Left
				right := queue[i].Right

				newLeftNode := &TreeNode{
					Val:   val,
					Left:  nil,
					Right: nil,
				}

				newRightNode := &TreeNode{
					Val:   val,
					Left:  nil,
					Right: nil,
				}

				queue[i].Left = newLeftNode
				queue[i].Right = newRightNode

				newLeftNode.Left = left
				newRightNode.Right = right
			}

			if queue[i].Left != nil {
				queue = append(queue, queue[i].Left)
			}

			if queue[i].Right != nil {
				queue = append(queue, queue[i].Right)
			}
		}

		queue = queue[length:]
	}

	return root
}
