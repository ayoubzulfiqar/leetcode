/*

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func insert(x int, t *TreeNode) *TreeNode {
	if t != nil {
		if x > t.Val {
			t.Right = insert(x, t.Right)
		} else {
			t.Left = insert(x, t.Left)
		}
		return t
	} else {
		return &TreeNode{Val: x}
	}
}

func generateTrees(n int) []*TreeNode {
	if n == 0 {
		return nil
	}

	lists := make([][]*TreeNode, 1)
	lists[0] = append(lists[0], nil)

	for len(lists) <= n {
		newTrees := []*TreeNode{}
		for root := 1; root <= len(lists); root++ {
			for _, left := range lists[root-1] {
				for _, right := range lists[len(lists)-root] {
					rootNode := &TreeNode{Val: root}
					rootNode.Left = left
					rootNode.Right = cloneTree(right, root)
					newTrees = append(newTrees, rootNode)
				}
			}
		}
		lists = append(lists, newTrees)
	}

	return lists[n]
}

func cloneTree(node *TreeNode, offset int) *TreeNode {
	if node == nil {
		return nil
	}
	newNode := &TreeNode{Val: node.Val + offset}
	newNode.Left = cloneTree(node.Left, offset)
	newNode.Right = cloneTree(node.Right, offset)
	return newNode
}



func printTree(t *TreeNode) string {
	if t == nil {
		return ""
	}
	leftStr := printTree(t.Left)
	rightStr := printTree(t.Right)
	if leftStr != "" {
		leftStr = " " + leftStr
	}
	if rightStr != "" {
		rightStr = " " + rightStr
	}
	return fmt.Sprintf("[%d%s%s]", t.Val, leftStr, rightStr)
}

*/

package main

import (
	"fmt"
)

// TreeNode represents the structure of a tree node.
type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func solve(start, end int, m map[[2]int][]*TreeNode) []*TreeNode {
	v := []*TreeNode{}
	if start > end {
		v = append(v, nil)
		return v
	}
	if start == end {
		v = append(v, &TreeNode{Val: start})
		return v
	}
	if cached, ok := m[[2]int{start, end}]; ok {
		return cached
	}
	for i := start; i <= end; i++ {
		l := solve(start, i-1, m)
		r := solve(i+1, end, m)
		for _, x := range l {
			for _, x1 := range r {
				root := &TreeNode{Val: i}
				root.Left = x
				root.Right = x1
				v = append(v, root)
			}
		}
	}
	m[[2]int{start, end}] = v
	return v
}

func generateTrees(n int) []*TreeNode {
	m := make(map[[2]int][]*TreeNode)
	return solve(1, n, m)
}

func printMain() {
	n := 3
	trees := generateTrees(n)
	fmt.Printf("Generated %d trees:\n", len(trees))
	for i, tree := range trees {
		fmt.Printf("Tree %d:\n", i+1)
		printTree(tree, 0)
		fmt.Println()
	}
}

func printTree(node *TreeNode, level int) {
	if node == nil {
		return
	}
	printTree(node.Right, level+1)
	fmt.Printf("%*s%d\n", level*4, "", node.Val)
	printTree(node.Left, level+1)
}
