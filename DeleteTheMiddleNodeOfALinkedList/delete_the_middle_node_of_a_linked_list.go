package main

// Definition for singly-linked list.
type ListNode struct {
	Val  int
	Next *ListNode
}

func deleteMiddle(head *ListNode) *ListNode {
	if head == nil || head.Next == nil {
		return nil
	}

	var previous, slow, fast *ListNode = nil, head, head

	// Time: O(n/2) = O(n)
	for slow != nil && fast != nil && fast.Next != nil {
		previous, slow, fast = slow, slow.Next, fast.Next.Next
	}

	previous.Next = slow.Next

	return head
}
