package main

// Definition for singly-linked list.
type ListNode struct {
	Val  int
	Next *ListNode
}

func middleNode(head *ListNode) *ListNode {
	var N int = 0
	var Temp *ListNode = head

	for Temp.Next != nil {
		Temp = Temp.Next
		N++
	}
	var mid int
	if N%2 == 0 {
		mid = N / 2
	} else {
		mid = N/2 + 1
	}
	var node *ListNode = head
	var i int = 0
	for i < mid {
		node = node.Next
		i++
	}
	return node
}

// ===== 2

// func middleNode(head *ListNode) *ListNode {
// 	var slow *ListNode = head
// 	var fast *ListNode = head
// 	for fast != nil && fast.Next != nil {
// 		slow = slow.Next
// 		fast = fast.Next.Next
// 	}
// 	return slow
// }

// ========== 3

// func middleNode(head *ListNode) *ListNode {
// 	var n int = 0
// 	var current *ListNode = head
// 	for current != nil {
// 		n++
// 		current = current.Next
// 	}
// 	current = head
// 	for i := 0; i < n/2; i++ {
// 		current = current.Next
// 	}
// 	return current
// }
