# 🔥 Dart || 4 Solutions || Simple Fast and Easy || with Explanation

## Definition of the Singly LinkedList

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
  ListNode? getIntersectionNode(ListNode? headA, headB) {
    ListNode? currentA = headA, currentB = headB;

    while (currentA != currentB) {
      if (currentA != null)
        currentA = currentA.next;
      else
        currentA = headB;
      if (currentB != null)
        currentB = currentB.next;
      else
        currentB = headA;
    }
    return currentA;
  }
}
```

## Solution - 2 Using HashSet

```dart

import 'dart:collection';

class Solution {
  ListNode? getIntersectionNode(ListNode? headA, headB) {
    HashSet<ListNode> hashSet = HashSet();

    while (headA != null) {
      hashSet.add(headA);
      headA = headA.next;
    }

    while (headB != null) {
      if (!hashSet.add(headB)) {
        return headB;
      }
      headB = headB.next;
    }
    return null;
  }
}
```

## Solution - 3

```dart
class Solution {
  ListNode? getIntersectionNode(ListNode? headA, headB) {
    if (headA == null || headB == null) return null;

    ListNode? a = headA;
    ListNode? b = headB;

    //if a & b have different len, then we will stop the loop after second iteration
    while (a != b) {
      //for the end of first iteration, we just reset the pointer to the head of another linked-list
      a = a == null ? headB : a.next;
      b = b == null ? headA : b.next;
    }

    return a;
  }
}
```

## Solution - 4 O(m+n)

```dart
class Solution {
  ListNode? getIntersectionNode(ListNode? headA, headB) {
    // Count the number of nodes in
    // both the linked list
    int c1 = getCount(headA);
    int c2 = getCount(headB);
    int d;

    // If first is greater
    if (c1 > c2) {
      d = c1 - c2;
      return _getIntersectionNode(d, headA, headB);
    } else {
      d = c2 - c1;
      return _getIntersectionNode(d, headB, headA);
    }
  }

  int getCount(ListNode? head) {
    int count = 0;
    while (head != null) {
      count++;
      head = head.next;
    }
    return count;
  }

  ListNode? _getIntersectionNode(int d, ListNode? head1, ListNode? head2) {
    // Stand at the starting of the bigger list
    ListNode? current1 = head1;
    ListNode? current2 = head2;

    // Move the pointer forward after d nodes
    for (int i = 0; i < d; i++) {
      if (current1 == null) {
        return null;
      }
      current1 = current1.next;
    }

    // Move both pointers of both list till they
    // intersect with each other
    while (current1 != null && current2 != null) {
      if (current1 == current2) return current1;

      // Move both the pointers forward
      current1 = current1.next;
      current2 = current2.next;

      return null;
    }
    return null;
  }
}
```

### Disclaimer:-

This solution you can't submit on leetcode because it is not available in DART language but i implemented in DART if somehow leetcode decided to be generous and let's us to  submit in DART language than we will be ready to slap in the head after submitting

## [GitHub Link](https://github.com/ayoubzulfiqar/leetcode)
