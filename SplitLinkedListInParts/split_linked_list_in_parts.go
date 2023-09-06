package main

// Definition for singly-linked list.
type ListNode struct {
	Val  int
	Next *ListNode
}

func splitListToParts(head *ListNode, k int) []*ListNode {
	current := head
	answer := make([]*ListNode, k)
	ptr := 0
	listLength := 0

	// Calculate the length of the linked list
	for current != nil {
		listLength++
		current = current.Next
	}

	// Calculate the extra elements in some parts
	extra := listLength % k
	// Calculate the base length for each part
	partLength := listLength / k
	current = head

	for current != nil {
		answer[ptr] = current
		// Calculate the length of the current part
		currentLength := partLength
		if extra > 0 {
			currentLength++
			extra--
		}

		// Move the current pointer to the end of the current part
		for i := 0; i < currentLength-1; i++ {
			current = current.Next
		}

		// Disconnect the current part from the next part
		temp := current.Next
		current.Next = nil
		current = temp

		ptr++
	}

	return answer
}
