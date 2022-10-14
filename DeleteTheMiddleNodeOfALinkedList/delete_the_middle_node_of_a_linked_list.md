# 🔥 Delete the Middle Node of a Linked List 🔥 || 3 Solutions|| Simple Fast and Easy || with Explanation

## Definition for singly-linked list

```dart
class ListNode {
  int val;
  ListNode? next;
  ListNode([this.val = 0, this.next]);
}
```

## Solution - 1 Two Pointers

```dart
class Solution {
// Runtime: 1071 ms, faster than 100.00% of Dart online submissions for Delete the Middle Node of a Linked List.
// Memory Usage: 206.4 MB, less than 100.00% of Dart online submissions for Delete the Middle Node of a Linked List.
  ListNode? deleteMiddle(ListNode? head) {
    if (head?.next == null) return null;
    // make fast start from 3rd node
    ListNode? slow = head, fast = head?.next?.next;
    // now we loop until fast reaches end of list
    while (fast != null && fast.next != null) {
      fast = fast.next?.next;
      slow = slow?.next;
    }

    // since we made fast start from 3rd node
    // when we exit the loop, the slow pointer
    // will be at node middle - 1 (not middle)
    // so we can easily delete middle node now
    slow?.next = slow.next?.next;
    return head;
  }
}
```

## Solution - 2 Optimized Solution TC: O(n) SC: O(1)

```dart
class Solution {
// Runtime: 1154 ms, faster than 100.00% of Dart online submissions for Delete the Middle Node of a Linked List.
// Memory Usage: 205.3 MB, less than 100.00% of Dart online submissions for Delete the Middle Node of a Linked List

  ListNode? deleteMiddle(ListNode? head) {
    // Edge Cases Covered
    if (head?.next == null) {
      return head?.next;
    }

    // StablePointer To Be Moved At Constant Speed
    ListNode? stablePointer = head;

    // UnstablePointer To Be Moved At Fast Speed (.next.next)
    ListNode? unstablePointer = head;

    // EntryPointer To Be Moved At Constant Speed But Will Stay Just Behind The StablePointer
    ListNode? entryPointer = null;

    while (unstablePointer != null && unstablePointer.next != null) {
      entryPointer = stablePointer;
      stablePointer = stablePointer?.next;
      unstablePointer = unstablePointer.next?.next;
    }

    // Delete The Next Node
    entryPointer?.next = entryPointer.next?.next;

    // Return Head
    return head;
  }
}
```

## Solution - 3 Brute Force Solution : Calculate Size TC: O(n) SC: O(1)

```dart
class Solution {
// Runtime: 1361 ms, faster than 100.00% of Dart online submissions for Delete the Middle Node of a Linked List.
// Memory Usage: 205.6 MB, less than 100.00% of Dart online submissions for Delete the Middle Node of a Linked List.

  ListNode? deleteMiddle(ListNode? head) {
    // Edge Case
    if (head?.next == null) {
      return head?.next;
    }

    // Variable size To Calculate Size
    ListNode? traverseNode = head;
    int size = 0;

    // Calculating Size
    while (traverseNode != null) {
      traverseNode = traverseNode.next;
      size++;
    }

    // Size Up-to Mid Point
    size = size ~/ 2;

    traverseNode = head;

    // Running Loop Till TraverseNode Is Pointing To The Node Just Before The Mid Node
    while (size > 1) {
      traverseNode = traverseNode?.next;
      size--;
    }

    // Delete Node
    traverseNode?.next = traverseNode.next?.next;

    // Returning The Modified Linked List
    return head;
  }
}
```
