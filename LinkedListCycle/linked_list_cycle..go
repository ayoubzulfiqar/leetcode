package main

// Definition for singly-linked list.
type ListNode struct {
	Val  int
	Next *ListNode
}

func hasCycle(head *ListNode) bool {
	if head == nil || head.Next == nil {
		return false
	}

	//set the 'mark' is over 10^5
	mark := 100001
	//marking
	head.Val = mark
	//move to next
	head = head.Next

	for head != nil && head.Next != nil {

		//When 'head' becomes the same as 'mark', it's Cycle.
		if head.Val == mark || head.Next.Val == mark {
			return true
		}

		//marking & move to next ( Two ahead )
		head.Val = mark
		head = head.Next.Next

	}

	return false

}
