/*

  -* Remove Duplicates from Sorted List *-

Given the head of a sorted linked list, delete all duplicates such that each element appears only once.
Return the linked list sorted as well.



Example 1:


Input: head = [1,1,2]
Output: [1,2]
Example 2:


Input: head = [1,1,2,3,3]
Output: [1,2,3]


Constraints:

The number of nodes in the list is in the range [0, 300].
-100 <= Node.val <= 100
The list is guaranteed to be sorted in ascending order.



*/

//* Definition for singly-linked list.
class ListNode {
  int val;
  ListNode? next;
  ListNode([this.val = 0, this.next]);
}

class A {
  ListNode? deleteDuplicates(ListNode? head) {
    // checking the value if it's empty or NULL
    if (head == null || head.next == null) return head;
    // first value in the list node
    ListNode? first = head;
    // second value in the list node
    ListNode? second = head.next;
    // assuming that second value is not NULL
    while (second != null) {
      // if the second value is same as first
      if (second.val == first?.val) {
        // than we will assign the second value as the third value -: first.next = second value
        first?.next = second.next;
        // than that third value is same as the second value
        second = second.next;
      } else {
        // if not first will be same as second value
        first = second;
        // second value will be same as third value
        second = second.next;
      }
    }

    return head;
  }
// Runtime: 424 ms, faster than 56.25% of Dart online submissions for Remove Duplicates from Sorted List.
// Memory Usage: 143.1 MB, less than 62.50% of Dart online submissions for Remove Duplicates from Sorted List.
}

class B {
  ListNode? deleteDuplicates(ListNode? head) {
    // checking the value if it's empty or NULL
    if (head == null || head.next == null) return head;

    ListNode? firstValue = head;
    while (firstValue != null || firstValue?.next != null) {
      if (firstValue?.val == firstValue?.next?.val) {
        firstValue?.next = firstValue.next?.next;
      } else {
        firstValue = firstValue?.next;
      }
    }
    return head;
  }
// 102 / 166 test cases passed.
// Status: Time Limit Exceeded
// Submitted: 0 minutes ago
// Last executed input:
// [-50,-50,-49,-49,-48,-47,-47,-45,-44,-44,-44,-44,-43,-41,-41,-40,-40,-40,-37,-37,-37,-36,-36,-34,-34,-34,-34,-34,-34,
}

class C {
  ListNode? deleteDuplicates(ListNode? head) {
    return null;
  }
}
