package main

type ListNode struct {
	Val  int
	Next *ListNode
}

// Runtime: 4 ms, faster than 72.67% of Go online submissions for Delete Node in a Linked List.
// Memory Usage: 2.9 MB, less than 67.73% of Go online submissions for Delete Node in a Linked List.
// func deleteNode(node *ListNode) {

// 	node.Val = node.Next.Val
// 	node.Next = node.Next.Next
// }

func deleteNode(node *ListNode) {

	node.Val = node.Next.Val
	node.Next = node.Next.Next

}
