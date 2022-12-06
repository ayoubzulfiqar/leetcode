package main

// Definition for singly-linked list.
type ListNode struct {
	Val  int
	Next *ListNode
}

func oddEvenList(head *ListNode) *ListNode {
	if head == nil || head.Next == nil {
		return head
	}
	var evenList *ListNode = &ListNode{Val: -1}
	var oddList *ListNode = &ListNode{Val: -1}
	var currentEven *ListNode = evenList
	var currentOdd *ListNode = oddList
	var current *ListNode = head
	var i int = 1
	for current != nil {
		if i%2 != 0 {
			currentOdd.Next = current
			currentOdd = current
			current = current.Next
		} else {
			currentEven.Next = current
			currentEven = current
			current = current.Next
		}
		i++
	}
	currentOdd.Next = evenList.Next
	currentEven.Next = nil
	return oddList.Next
}

// func oddEvenList(head *ListNode) *ListNode {
// 	if head == nil {
// 		return head
// 	}
// 	oddNode := head
// 	evenNode := head.Next
// 	even := evenNode
// 	for evenNode != nil && evenNode.Next != nil {
// 		oddNode.Next = oddNode.Next.Next
// 		evenNode.Next = evenNode.Next.Next
// 		oddNode = oddNode.Next
// 		evenNode = evenNode.Next
// 	}
// 	oddNode.Next = even
// 	return head
// }
