# 🔥 Reverse Linked List 🔥 || 3 Solutions || Simple Fast and Easy || with Explanation

## Definition for singly-linked list

```dart
class ListNode {
  int val;
  ListNode? next;
  ListNode([this.val = 0, this.next]);
}
```

## Solution - 1 Iterative O(n)

```dart
class Solution {
// Runtime: 322 ms, faster than 95.89% of Dart online submissions for Reverse Linked List.
// Memory Usage: 156.1 MB, less than 15.07% of Dart online submissions for Reverse Linked List.

  ListNode? reverseList(ListNode? head) {
    // previous value is null because we donn't know if it exists of not
    ListNode? previous = null;
    // we are at current value mean the first value head
    ListNode? current = head;
    // we don't know if there is next value or not so null
    ListNode? next = null;
    // if we assume there is a value at the start of the list
    while (current != null) {
      // storing the next element
      next = current.next;
      // we changing the next of the current value - reversing
      current.next = previous;
      // moving the previous and current on step forward
      previous = current;
      current = next;
    }
    head = previous;
    return head;
  }
}
```

## Solution - 2 Recursive O(n)

```dart
class Solution {
// Runtime: 377 ms, faster than 78.08% of Dart online submissions for Reverse Linked List.
// Memory Usage: 142.7 MB, less than 60.27% of Dart online submissions for Reverse Linked List.
  ListNode? reverseList(ListNode? head) {
    if (head == null || head.next == null) return head;
    // reversing the rest list and put the fist  element at the end
    ListNode? rest = reverseList(head.next);
    // linking the rest of the list to head
    head.next?.next = head;
    head.next = null;
    // fixing the hed pointer
    return rest;
  }
}
```

## Solution - 3 Don't Panic := Using Queue as STACK

```dart
import 'dart:collection';

class Solution {
//   Runtime: 319 ms, faster than 98.63% of Dart online submissions for Reverse Linked List.
// Memory Usage: 161.1 MB, less than 5.48% of Dart online submissions for Reverse Linked List.
  ListNode? reverseList(ListNode? head) {
    if (head == null || head.next == null) return head;

    Queue<ListNode> stack = Queue();
    while (head != null) {
      stack.add(head);
      head = head.next;
    }

    ListNode? nHead = stack.last;
    ListNode? p;
    while (stack.isNotEmpty) {
      p = stack.removeLast();

      if (stack.isNotEmpty) {
        ListNode? pre = stack.last;
        p.next = pre;
      } else
        p.next = null;
    }
    return nHead;
  }
}
```
