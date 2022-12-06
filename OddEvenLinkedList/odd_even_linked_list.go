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

/*


ListNode? oddEvenList(ListNode? head) {
    if (head == null || head.next == null) {
      return head;
    }

    ListNode? evenList = ListNode(-1);
    ListNode? oddList = ListNode(-1);

    ListNode? currentEven = evenList;
    ListNode? currentOdd = oddList;

    ListNode? current = head;
    int i = 1;
    while (current != null) {
      if (i % 2 != 0) {
        currentOdd?.next = current;
        currentOdd = current;
        current = current.next;
      } else {
        currentEven?.next = current;
        currentEven = current;
        current = current.next;
      }
      i++;
    }
    currentOdd?.next = evenList.next;
    currentEven?.next = null;
    return oddList.next;
  }

*/

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
