# 🔥 Dart || 5 Solutions || Simple Fast Easy with Explanation

## Definition for singly-linked list

```dart
class ListNode {
  int val;
  ListNode? next;
  ListNode([this.val = 0, this.next]);
}
```

## Solution - 1 Two Pointers

### Core Strategy

For this problem, let's see what will happen if there's a circle.
If it's a little abstract, then let's think about we are running on a circular track.

If the track is 100m long, your speed is 10m/s, your friend's speed is 5m/s. Then after 20s, you've run 200m, your friend has run 100m. But because the track is circular, so you will be at the same place with your friend since the difference between your distances is exactly 100m.

How about we change another track, change the speed of you and your friend? As long as your speeds are not the same, the faster person will always catch up with the slower person again.

That's the key point for this problem.

### Approach

We just need to follow the strategy above - make a slower pointer and a faster pointer. Then we loop and loop again:

if the fast pointer catch up with slow pointer, then it's a circular linked list
if the fast pointer get to the end, then it's not a circular linked list

```dart
class Solution {
  bool hasCycle(ListNode? head) {
    ListNode? fast = head;
    while (fast != null && fast.next != null) {
      head = head?.next;
      fast = fast.next?.next;
      if (head == fast) return true;
    }
    return false;
  }
}
```

## Solution - 2

```dart
class Solution {
  bool hasCycle(ListNode? head) {
    if (head == null) return false;
    ListNode? fast = head, slow = head;
    while (fast?.next != null && fast?.next?.next != null) {
      slow = slow?.next;
      fast = fast?.next?.next;
      if (fast == slow) return true;
    }
    return false;
  }
}
```

## Solution - 3 Swapping nodes

```dart
class Solution {
  bool hasCycle(ListNode? head) {
    ListNode? tmp = null;
    while (head == null) {
      if (head == head?.next) return true;
      tmp = head?.next;
      head?.next = head;
      head = tmp;
    }
    return false;
  }
}
```

## Solution - 4  O(1) Space Solution

```dart
class Solution {
  bool hasCycle(ListNode? head) {
    if (head == null) return false;
    ListNode? walker = head;
    ListNode? runner = head;
    while (runner!.next != null && runner.next!.next != null) {
      walker = walker!.next;
      runner = runner.next!.next;
      if (walker == runner) return true;
    }
    return false;
  }
}
```

## Solution - 5 Using HashSet

```dart

import 'dart:collection';

class Solution {
  bool hasCycle(ListNode? head) {
    HashSet s = HashSet();
    for (ListNode? current = head; current != null; current = current.next) {
      if (s.contains(current)) {
        return true;
      }
      s.add(current);
    }
    return false;
  }
}

```

## [GitHub Link](https://github.com/ayoubzulfiqar/leetcode)

## Disclaimer:-

This question is not available in Dart language on leetcode i don't know Why but I solved it in different ways to show case how we can achieve the result using different methods. I hope in future this question available in dart.
HOPE FOR THE BEST.
