package main

// Definition for a binary tree node.
type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func pseudoPalindromicPaths(root *TreeNode) int {
	bitMask, resCnt := 0, 0
	maskQueue, nodeQueue := []int{0}, []*TreeNode{root}
	curNode := root
	for len(nodeQueue) > 0 {
		curNode, nodeQueue = nodeQueue[0], nodeQueue[1:]
		bitMask, maskQueue = maskQueue[0], maskQueue[1:]
		if curNode.Left == nil && curNode.Right == nil {
			bitMask ^= 1 << curNode.Val
			if bitMask&(bitMask-1) == 0 {
				resCnt += 1
			}
		}
		if curNode.Left != nil {
			maskQueue = append(maskQueue, bitMask^(1<<curNode.Val))
			nodeQueue = append(nodeQueue, curNode.Left)
		}
		if curNode.Right != nil {
			maskQueue = append(maskQueue, bitMask^(1<<curNode.Val))
			nodeQueue = append(nodeQueue, curNode.Right)
		}
	}
	return resCnt
}
