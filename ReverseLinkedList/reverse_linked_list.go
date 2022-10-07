package main

// Definition for singly-linked list.
type ListNode struct {
	Val  int
	Next *ListNode
}

func reverseList(head *ListNode) *ListNode {
	//	Runtime: 0 ms, faster than 100.00% of Go online submissions for Reverse Linked List.
	//	Memory Usage: 2.6 MB, less than 77.80% of Go online submissions for Reverse Linked List.
	var previous, current *ListNode = nil, head
	for current != nil {
		previous, current, current.Next = current, current.Next, previous
	}
	return previous
}
