package main

// Definition for singly-linked list.
type ListNode struct {
	Val  int
	Next *ListNode
}

// func isPalindrome(head *ListNode) bool {
// 	return palindrome(head, head)
// }

// func palindrome(head, tail *ListNode) bool {
// 	if tail.Next != nil {
// 		if !palindrome(head, tail.Next) { // jump to the last Node
// 			return false
// 		}
// 	}
// 	if head.Val != tail.Val {
// 		return false
// 	}
// 	if head != tail { // move head to next
// 		*head = *head.Next
// 	}
// 	return true
// }

// func isPalindrome(head *ListNode) bool {
// 	stack, next := half(head)
// 	for i := len(stack) - 1; next != nil; i-- {
// 		if stack[i].Val != next.Val {
// 			return false
// 		}
// 		next = next.Next
// 	}
// 	return true
// }

// func half(head *ListNode) ([]*ListNode, *ListNode) {
// 	stack := make([]*ListNode, 0, 8)
// 	for fast := head; fast != nil && fast.Next != nil; head = head.Next {
// 		stack = append(stack, head)
// 		fast = fast.Next.Next
// 		if fast == nil {
// 			break
// 		}
// 	}
// 	return stack, head.Next
// }

func isPalindrome(head *ListNode) bool {
	for left, right := partition2(head); left != nil; left, right = left.Next, right.Next {
		if left.Val != right.Val {
			return false
		}
	}
	return true
}

func partition2(head *ListNode) (left *ListNode, right *ListNode) {
	right = head.Next
	for fast := head; fast.Next != nil; {
		fast = fast.Next.Next
		// Critical, reverse operation must happens after fast forwarding.
		// Reverse the left half side
		left, head.Next = head, left
		if fast == nil {
			break
		}
		// Critical, right is faster 1 step than head
		// Forward to the front of the right half side
		head, right = right, right.Next
	}
	return
}
