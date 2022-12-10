package main

// Definition for a binary tree node.
type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func maxProduct(root *TreeNode) int {
	pos := make([]int64, 0)
	sum := helper(root, &pos)
	mod := int64(1e9) + 7
	res := int64(0)
	for i := range pos {
		temp := int64(sum-pos[i]) * int64(pos[i])
		res = max(res, temp)
	}
	return int(res % mod)
}

func helper(root *TreeNode, pos *[]int64) int64 {
	if root == nil {
		return 0
	} else {
		l := helper(root.Left, pos)
		r := helper(root.Right, pos)
		temp := l + r + int64(root.Val)
		*pos = append(*pos, temp)
		return temp
	}
}
func max(a, b int64) int64 {
	if a > b {
		return a
	}
	return b
}
