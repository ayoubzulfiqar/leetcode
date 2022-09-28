# 🔥 DART || 3 Solutions || With explanation

## Definition for singly-linked list

```dart
class ListNode {
  int val;
  ListNode? next;
  ListNode([this.val = 0, this.next]);
}
```

## Solution - 1 Two-Pointers

```dart
class Solution {
// Runtime: 465 ms, faster than 52.94% of Dart online submissions for Remove Nth Node From End of List.
// Memory Usage: 142.4 MB, less than 88.24% of Dart online submissions for Remove Nth Node From End of List.
  ListNode? removeNthFromEnd(ListNode? head, int n) {
    // if the head is null we will simply return null
    if (head == null) return null;
    // Two pointers of our linked list
    ListNode? fast = head;
    ListNode? slow = head;
    // looping through the value and pointing it to the next
    for (int i = 1; i <= n; ++i) fast = fast!.next;
    // if the previous value is null but next is not
    ListNode? prev = null;
    // while the first pointer is not null
    while (fast != null) {
      //  fast will hold the next value
      fast = fast.next;
      // previous will hold the second pointer
      prev = slow;
      slow = slow!.next;
    }
    // if previous is null
    if (prev == null) {

      // head will pint to the next value
      head = head.next;
    } else {
      prev.next = slow!.next;
      slow.next = null;
    }
    // else we  will simply return head
    return head;
  }
}
```

## Solution - 2 Three Pointers

Approach :- First increase the fast pointer by n steps to ensure that when the fast pointer points to null , at the same time, the slow pointer points to the location of the node which is to be removed
fast pointer : to move n steps ahead of slow pointer
slow pointer : this will point to the exact node which is to be removed once the fast pointer reaches null
prev pointer: this will point to the node before the slow pointer because this pointer will bypass the node which is to be removed and get connected directly to the node next to slow.

```dart
class Solution {
// Runtime: 509 ms, faster than 50.00% of Dart online submissions for Remove Nth Node From End of List.
// Memory Usage: 142.5 MB, less than 79.41% of Dart online submissions for Remove Nth Node From End of List.
  ListNode? removeNthFromEnd(ListNode? head, int n) {
    ListNode? fast = head;
    ListNode? slow = head;
    ListNode? prev = null;
    //Loop to take the fast pointer n steps ahead of the slow pointer.
    while (n > 0) {
      fast = fast?.next;
      n--;
    }
    //If fast pointer points to null, it means that the node has to be removed from the beginning.
    if (fast == null) return slow?.next;

    while (fast != null) {
      fast = fast.next;
      prev = slow;
      slow = slow?.next;
    }

    if (prev != null)
      prev.next = slow?.next;
    else if (prev == null) return null;
    return head;
  }
}
```

## Solution - 3 Without Using Dummy Node

```dart
class Solution {
// Runtime: 488 ms, faster than 52.94% of Dart online submissions for Remove Nth Node From End of List.
// Memory Usage: 142.4 MB, less than 79.41% of Dart online submissions for Remove Nth Node From End of List.
  ListNode? removeNthFromEnd(ListNode? head, int n) {
    ListNode? fast = head, slow = head;
    for (int i = 1; i <= n; i++) fast = fast?.next;
    // for cases where n = length of linked-list i.e. if first node is to be deleted
    if (fast == null) {
      head = head?.next;
      return head;
    }
    while (fast?.next != null) {
      slow = slow?.next;
      fast = fast?.next;
    }
    slow?.next = slow.next?.next;
    return head;
  }
}
```

## Bonus Solution - Golang

```go
// Runtime: 0 ms, faster than 100.00% of Go online submissions for Remove Nth Node From End of List.
// Memory Usage: 2.3 MB, less than 31.13% of Go online submissions for Remove Nth Node From End of List.

func removeNthFromEnd(head *ListNode, n int) *ListNode {
	dummy := new(ListNode)
	dummy.Next = head
	fast := head
	slow := dummy
	for i := 0; i < n; i++ {
		fast = fast.Next
	}

	for fast != nil {
		fast = fast.Next
		slow = slow.Next
	}

	slow.Next = slow.Next.Next

	return dummy.Next
}

```
