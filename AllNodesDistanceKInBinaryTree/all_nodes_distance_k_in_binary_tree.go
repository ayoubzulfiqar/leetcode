package main

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func parentChild(child *TreeNode, parent *TreeNode, mpp map[*TreeNode]*TreeNode) {
	if child == nil {
		return
	}
	if parent == nil {
		parent = child
	} else {
		mpp[child] = parent
	}
	parentChild(child.Left, child, mpp)
	parentChild(child.Right, child, mpp)
}

func distanceK(root *TreeNode, target *TreeNode, k int) []int {
	mpp := make(map[*TreeNode]*TreeNode)
	parentChild(root, nil, mpp)
	q := []*TreeNode{}
	visited := make(map[*TreeNode]bool)
	ans := []int{}

	q = append(q, target)
	visited[target] = true
	distance := 0

	for len(q) > 0 {
		size := len(q)
		for i := 0; i < size; i++ {
			temp := q[0]
			q = q[1:]

			leftChild := temp.Left
			rightChild := temp.Right

			if leftChild != nil && !visited[leftChild] {
				q = append(q, leftChild)
				visited[leftChild] = true
			}

			if rightChild != nil && !visited[rightChild] {
				q = append(q, rightChild)
				visited[rightChild] = true
			}

			if mpp[temp] != nil && !visited[mpp[temp]] {
				q = append(q, mpp[temp])
				visited[mpp[temp]] = true
			}

			if distance == k {
				ans = append(ans, temp.Val)
			}
		}
		distance++
		if distance > k {
			break
		}
	}
	return ans
}

// func main() {
// 	// Test case
// 	root := &TreeNode{Val: 3}
// 	root.Left = &TreeNode{Val: 5}
// 	root.Right = &TreeNode{Val: 1}
// 	root.Left.Left = &TreeNode{Val: 6}
// 	root.Left.Right = &TreeNode{Val: 2}
// 	root.Right.Left = &TreeNode{Val: 0}
// 	root.Right.Right = &TreeNode{Val: 8}
// 	root.Left.Right.Left = &TreeNode{Val: 7}
// 	root.Left.Right.Right = &TreeNode{Val: 4}

// 	target := root.Left
// 	k := 2

// 	result := distanceK(root, target, k)
// 	fmt.Println(result) // Output: [7, 4]
// }
