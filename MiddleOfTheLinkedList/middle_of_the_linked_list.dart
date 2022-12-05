/*



-* 876. Middle of the Linked List *-


Given the head of a singly linked list, return the middle node of the linked list.

If there are two middle nodes, return the second middle node.

 

Example 1:


Input: head = [1,2,3,4,5]
Output: [3,4,5]
Explanation: The middle node of the list is node 3.
Example 2:


Input: head = [1,2,3,4,5,6]
Output: [4,5,6]
Explanation: Since the list has two middle nodes with values 3 and 4, we return the second one.
 

Constraints:

The number of nodes in the list is in the range [1, 100].

*/

// Definition for singly-linked list.
class ListNode {
  int val;
  ListNode? next;
  ListNode([this.val = 0, this.next]);
}

class A {
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

class B {
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

class C {
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
