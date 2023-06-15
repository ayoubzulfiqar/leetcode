package main

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func maxLevelSum(root *TreeNode) int {
	levelSums := make([]int, 100)
	height := 1

	dfs(root, 1, &levelSums, &height)

	maxSumLevel := 1
	for level := 2; level <= height; level++ {
		if levelSums[maxSumLevel] < levelSums[level] {
			maxSumLevel = level
		}
	}

	return maxSumLevel
}

func dfs(root *TreeNode, level int, levelSums *[]int, height *int) {
	if root == nil {
		return
	}

	if level > *height {
		*height = level
	}
	ensureCapacity(levelSums, *height)

	(*levelSums)[level] += root.Val

	dfs(root.Left, level+1, levelSums, height)
	dfs(root.Right, level+1, levelSums, height)
}

func ensureCapacity(levelSums *[]int, height int) {
	if height == len(*levelSums) {
		newLevelSums := make([]int, height<<1)
		copy(newLevelSums, *levelSums)
		*levelSums = newLevelSums
	}
}
