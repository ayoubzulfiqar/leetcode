/*

-* Remove Linked List Elements *-


Given the head of a linked list and an integer val, remove all the nodes of the linked list that has Node.val == val, and return the new head.



Example 1:


Input: head = [1,2,6,3,4,5,6], val = 6
Output: [1,2,3,4,5]
Example 2:

Input: head = [], val = 1
Output: []
Example 3:

Input: head = [7,7,7,7], val = 7
Output: []


Constraints:

The number of nodes in the list is in the range [0, 104].
1 <= Node.val <= 50
0 <= val <= 50

*/

// Definition for singly-linked list.
class ListNode {
  int val;
  ListNode? next;
  ListNode([this.val = 0, this.next]);
}

class A {
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

class B {
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

class C {
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
