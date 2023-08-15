package main

type ListNode struct {
	Val  int
	Next *ListNode
}

func merge(firstList *ListNode, secondList *ListNode, x int) *ListNode {
	if firstList == nil {
		return secondList
	}
	if secondList == nil {
		return firstList
	}

	newHead := &ListNode{Val: -9}
	temp := newHead

	for firstList != nil && secondList != nil {
		if firstList.Val < x {
			temp.Next = firstList
			firstList = firstList.Next
		} else if secondList.Val < x {
			temp.Next = secondList
			secondList = secondList.Next
		} else {
			break
		}
		temp = temp.Next
	}

	if firstList != nil {
		temp.Next = firstList
		for temp.Next != nil {
			temp = temp.Next
		}
	}

	if secondList != nil {
		temp.Next = secondList
	}

	return newHead.Next
}

func partition(head *ListNode, x int) *ListNode {
	if head == nil || head.Next == nil {
		return head
	}

	temp := head
	slow := head.Next
	fast := slow.Next

	for fast != nil && fast.Next != nil {
		temp = slow
		slow = slow.Next
		fast = fast.Next.Next
	}

	temp.Next = nil

	return merge(partition(head, x), partition(slow, x), x)
}
