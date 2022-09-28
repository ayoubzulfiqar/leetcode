package main

// Definition for singly-linked list.
type ListNode struct {
	Val  int
	Next *ListNode
}

func getIntersectionNode(headA, headB *ListNode) *ListNode {
	curA, curB := headA, headB

	// A, B will meet at either intersection node or Nil on the tail
	for curA != curB {

		if curA != nil {
			curA = curA.Next

		} else {
			// hop to headB if current A is Nil
			curA = headB
		}

		if curB != nil {
			curB = curB.Next
		} else {
			// hop to headA if current B is nil
			curB = headA
		}

	}

	return curA
}
