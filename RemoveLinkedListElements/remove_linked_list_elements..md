# 🔥 Remove Linked List Elements 🔥 || 3 SOlutions || Simple Fast and Easy || with Explanation

## Solution - 1 Recursive

```dart
class Solution {
  ListNode? removeElements(ListNode? head, int val) {
    // if the head  iss null return null because it's empty
    if (head == null) return null;
    // if he next element is than remove the next element and val
    head.next = removeElements(head.next, val);
    // if the head is same as val  we will to the next
    if (head.val == val) return head.next;
    // and return the head value whatever wwe have left
    return head;
  }
}
```

## Solution - 2 Two Pointers

```dart
class Solution {
  ListNode? removeElements(ListNode? head, int val) {
    // if the head is null means there is no element
    if (head == null) return null;
    // currently we are at the first head which is our current value
    ListNode? current = head;
    // previous is null because we have not went ahead of the current head
    ListNode? previous = null;
    // Assuming that the our  current head is not null
    while (current != null) {
      // if at the head the value  is same our given value
      if (current.val == val) {
        // and the while going forward that the previous is also not null
        if (previous != null)
          // than we will move forward
          previous.next = current.next;
        else
          // Than our head will point to the next value value to reach the next value
          head = head?.next;
      } else {
        // otherwise our previous will stay the current
        previous = current;
      }
      // or current will point to the next current
      current = current.next;
    }
    return head;
  }
}
```

## Solution - 3

```dart
class Solution {
  ListNode? removeElements(ListNode? head, int val) {
    ListNode? helper = ListNode(0);
    helper.next = head;
    ListNode p = helper;

    while (p.next != null) {
      if (p.next?.val == val) {
        ListNode? next = p.next;
        p.next = next?.next;
      } else {
        p = p.next!;
      }
    }

    return helper.next;
  }
}
```
