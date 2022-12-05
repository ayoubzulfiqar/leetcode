# 🔥 Middle of the Linked List 🔥 || 3 Approaches || Simple Fast and Easy || with Explanation

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
  ListNode? middleNode(ListNode? head) {
    int n = 0;
    ListNode? temp = head;

    while (temp!.next != null) {
      temp = temp.next;
      n++;
    }

    int mid = (n % 2 == 0) ? (n ~/ 2) : (n ~/ 2 + 1);

    ListNode? node = head;
    int i = 0;
    while (i < mid) {
      node = node?.next;
      i++;
    }

    return node;
  }
}
```

## Solution - 2 Two Pointers

```dart
class Solution {
  ListNode? middleNode(ListNode? head) {
    ListNode? slow = head;
    ListNode? fast = head;

    while (fast != null && fast.next != null) {
      slow = slow!.next;
      fast = fast.next!.next;
    }

    return slow;
  }
}
```

## Solution - 3 Brute Force

```dart

class Solution {
  ListNode? middleNode(ListNode? head) {
    int n = 0;
    ListNode? current = head;
    while (current != null) {
      n++;
      current = current.next;
    }
    current = head;
    for (int i = 0; i < n / 2; i++) {
      current = current?.next;
    }
    return current;
  }
}
```
