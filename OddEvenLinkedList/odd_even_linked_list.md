# 🔥 Odd Even Linked List 🔥 || 3  Approaches || Simple Fast and Easy || with Explanation

## Definition for singly-linked list

```dart
class ListNode {
  int val;
  ListNode? next;
  ListNode([this.val = 0, this.next]);
}
```

## Solution - 1

```dart
class Solution {
  ListNode? oddEvenList(ListNode? head) {
    if (head != null) {
      ListNode? odd = head, even = head.next, evenHead = even;

      while (even != null && even.next != null) {
        odd?.next = odd.next?.next;
        even.next = even.next?.next;
        odd = odd?.next;
        even = even.next;
      }
      odd?.next = evenHead;
    }
    return head;
  }
}
```

## Solution - 2

```dart
class Solution {
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
}
```

## Solution - 3

```dart
class Solution {
  ListNode? oddEvenList(ListNode? head) {
    ListNode? lastInEven = null;
    ListNode? temp = head;
    while (head != null && head.next != null) {
      ListNode? next = head.next;
      if (lastInEven == null) lastInEven = next;
      ListNode? temp = lastInEven?.next;
      if (temp == null) break;
      head.next = temp;
      lastInEven?.next = temp.next;
      temp.next = next;
      lastInEven = lastInEven?.next;
      head = head.next;
      if (lastInEven == null) break;
    }
    return temp;
  }
}
```
