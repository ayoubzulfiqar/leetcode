package main

import (
	"strconv"
	"strings"
)

// Definition for a binary tree node.
type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

type nodePath struct {
	node     *TreeNode
	prevPath []int
}

func binaryTreePaths(root *TreeNode) []string {
	res := make([]string, 0)

	stack := make([]nodePath, 0)
	stack = append(stack, nodePath{root, []int{}})

	var sb strings.Builder
	for len(stack) > 0 {
		cur := stack[len(stack)-1]
		stack = stack[:len(stack)-1]

		if cur.node.Left == nil && cur.node.Right == nil {
			for _, n := range cur.prevPath {
				sb.WriteString(strconv.Itoa(n))
				sb.WriteString("->")
			}
			sb.WriteString(strconv.Itoa(cur.node.Val))
			res = append(res, sb.String())
			sb.Reset()
		}

		if cur.node.Left != nil {
			stack = append(stack, nodePath{cur.node.Left, append(cur.prevPath, cur.node.Val)})
		}
		if cur.node.Right != nil {
			stack = append(stack, nodePath{cur.node.Right, append(cur.prevPath, cur.node.Val)})
		}
	}

	return res
}

// func binaryTreePaths(root *TreeNode) []string {
// 	return binaryTreePathsWithString(root, "")
// }

// func binaryTreePathsWithString(node *TreeNode, str string) []string {
// 	if node == nil {
// 		return []string{}
// 	}

// 	if node.Left == nil && node.Right == nil {
//         str += fmt.Sprint(node.Val)
// 		return []string{str}
// 	}

//     str += fmt.Sprintf("%v->", node.Val)

// 	return append(
//         binaryTreePathsWithString(node.Left, str),
//         binaryTreePathsWithString(node.Right, str)...,
//     )
// }
