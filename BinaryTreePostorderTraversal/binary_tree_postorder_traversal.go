package main

// Definition for a binary tree node.
type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func postorderTraversal(root *TreeNode) []int {

	// empty tree
	if root == nil {
		return []int{}
	}

	nodeStack := []*TreeNode{root} // the nodes
	nodesSeen := []bool{false}     // whether a node already seen
	values := make([]int, 0)       // values in postorder

	// traverse tree with stack
	for len(nodeStack) != 0 {
		node := nodeStack[len(nodeStack)-1]

		// leaf -> node seen; or children traversed
		if (node.Left == nil && node.Right == nil) || nodesSeen[len(nodesSeen)-1] {
			values = append(values, node.Val)
			nodeStack = nodeStack[:len(nodeStack)-1] // pop node
			nodesSeen = nodesSeen[:len(nodesSeen)-1]
			continue
		}

		nodesSeen[len(nodesSeen)-1] = true // mark node as seen

		// push children on stack
		if node.Right != nil {
			nodeStack = append(nodeStack, node.Right)
			nodesSeen = append(nodesSeen, false)
		}
		if node.Left != nil { // traversed first, therefore put on stack second
			nodeStack = append(nodeStack, node.Left)
			nodesSeen = append(nodesSeen, false)
		}
	}

	return values
}
