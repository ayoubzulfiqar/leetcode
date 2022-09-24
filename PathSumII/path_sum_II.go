package main

// Definition for a binary tree node.
type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func pathSum(root *TreeNode, targetSum int) [][]int {
	var allPaths [][]int
	var currentPath []int

	helper(root, currentPath, &allPaths, targetSum)

	return allPaths
}

func helper(root *TreeNode, currentPath []int, allPaths *[][]int, targetSum int) {
	if root == nil {
		return
	}

	newCurrentPath := make([]int, len(currentPath))
	copy(newCurrentPath, currentPath)
	newCurrentPath = append(newCurrentPath, root.Val)

	if root.Val == targetSum && root.Left == nil && root.Right == nil {
		*allPaths = append(*allPaths, newCurrentPath)
	} else {
		helper(root.Left, newCurrentPath, allPaths, targetSum-root.Val)
		helper(root.Right, newCurrentPath, allPaths, targetSum-root.Val)
	}
}

// func pathSum(root *TreeNode, targetSum int) [][]int {
//     solution := make([][]int, 0)
//     if root == nil {
//         return solution
//     }

//     return pathSumWith(root, targetSum, []int{}, solution)
// }

// func pathSumWith(node *TreeNode, targetSum int, path []int, solution [][]int) [][]int {
//     if node == nil {
//         return solution
//     }

//     targetSum -= node.Val

//     newPath := make([]int, len(path))
//     copy(newPath, path)
//     newPath = append(newPath, node.Val)

//     if node.Left == nil && node.Right == nil {
//         if targetSum == 0 {
//             solution = append(solution, newPath)
//         }
//         return solution
//     }

//     return append(
//         pathSumWith(node.Left, targetSum, newPath, solution),
//         pathSumWith(node.Right, targetSum, newPath, solution)...,
//     )
// }
