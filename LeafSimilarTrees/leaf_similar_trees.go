package main

// Definition for a binary tree node.
type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func leafSimilar(root1 *TreeNode, root2 *TreeNode) bool {
	ch1, ch2 := make(chan int), make(chan int)
	// add third parameter to separate root node and intermediate nodes
	go iterate(root1, ch1, true)
	go iterate(root2, ch2, true)
	for true {
		v1, ok1 := <-ch1
		v2, ok2 := <-ch2
		// if the lengths are different, ok values will be different too
		if ok1 != ok2 || v1 != v2 {
			return false
		}
		// both channels are closed, we're done
		if !ok1 && !ok2 {
			return true
		}
	}
	return false
}

func iterate(node *TreeNode, ch chan int, isRoot bool) {
	if node == nil {
		if isRoot {
			close(ch)
		}
		return
	}
	if node.Left != nil {
		iterate(node.Left, ch, false)
	}
	if node.Right != nil {
		iterate(node.Right, ch, false)
	}
	if node.Left == nil && node.Right == nil {
		ch <- node.Val
	}
	// close channel after all leaves are visited
	if isRoot {
		close(ch)
	}
}
