package main

import "math"

// Definition for a binary tree node.
type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func minDepth(root *TreeNode) int {
	if root == nil {
		return 0
	}

	if root.Left == nil && root.Right == nil {

		return 1
	} else if root.Left != nil && root.Right == nil {

		return minDepth(root.Left) + 1
	} else if root.Left == nil && root.Right != nil {

		return minDepth(root.Right) + 1
	} else {

		l := minDepth(root.Left)
		r := minDepth(root.Right)
		return int(math.Min(float64(l), float64(r))) + 1
	}

}

// func minDepth(root *TreeNode) int {
//     if root == nil {
//         return 0
//     }
//     var currentDepth int = 1

//     queue := NewTreeNodeQueue()
//     queue.Enqueue(root)

//     for !queue.IsEmpty() {
//         level := queue.Size()

//         for i := 0; i < level; i++ {
//             node := queue.Dequeue()
//             if !HasChildren(node) {
//                 return currentDepth
//             }
//             queue.EnqueueChildren(node)
//         }

//         currentDepth++
//     }
//     return currentDepth
// }

// func HasChildren(node *TreeNode) bool {
//     return node.Left != nil || node.Right != nil
// }

// type TreeNodeQueue struct {
//     items []*TreeNode
// }

// func NewTreeNodeQueue() *TreeNodeQueue {
//     return &TreeNodeQueue{
//         items: make([]*TreeNode, 0),
//     }
// }

// func (q *TreeNodeQueue) EnqueueChildren(n *TreeNode) {
//     if n.Left != nil {
//         q.Enqueue(n.Left)
//     }
//     if n.Right != nil {
//         q.Enqueue(n.Right)
//     }
// }

// func (q *TreeNodeQueue) Enqueue(n *TreeNode) {
//     q.items = append(q.items, n)
// }

// func (q *TreeNodeQueue) Dequeue() *TreeNode {
//     if q.IsEmpty() {
//         return nil
//     }

//     n := q.items[0]
//     q.items = q.items[1:]
//     return n
// }

// func (q *TreeNodeQueue) Size() int {
//     return len(q.items)
// }

// func (q *TreeNodeQueue) IsEmpty() bool {
//     return q.Size() == 0
// }
