/*

-* Linked List Cycle *-


Given head, the head of a linked list, determine if the linked list has a cycle in it.

There is a cycle in a linked list if there is some node in the list that can be reached again by continuously following the next pointer. Internally, pos is used to denote the index of the node that tail's next pointer is connected to. Note that pos is not passed as a parameter.

Return true if there is a cycle in the linked list. Otherwise, return false.



Example 1:


Input: head = [3,2,0,-4], pos = 1
Output: true
Explanation: There is a cycle in the linked list, where the tail connects to the 1st node (0-indexed).
Example 2:


Input: head = [1,2], pos = 0
Output: true
Explanation: There is a cycle in the linked list, where the tail connects to the 0th node.
Example 3:


Input: head = [1], pos = -1
Output: false
Explanation: There is no cycle in the linked list.


Constraints:

The number of the nodes in the list is in the range [0, 104].
-105 <= Node.val <= 105
pos is -1 or a valid index in the linked-list.


Follow up: Can you solve it using O(1) (i.e. constant) memory?


*/

// Definition for singly-linked list.

import 'dart:collection';

class ListNode {
  int val;
  ListNode? next;
  ListNode([this.val = 0, this.next]);
}

class A {
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

class B {
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

class C {
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

// O(1) Space Solution
class D {
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

// Using HashSet

class E {
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
