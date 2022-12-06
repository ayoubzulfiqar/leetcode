/*


-* 328. Odd Even Linked List *-

Given the head of a singly linked list, group all the nodes with odd indices together followed by the nodes with even indices, and return the reordered list.

The first node is considered odd, and the second node is even, and so on.

Note that the relative order inside both the even and odd groups should remain as it was in the input.

You must solve the problem in O(1) extra space complexity and O(n) time complexity.

 

Example 1:


Input: head = [1,2,3,4,5]
Output: [1,3,5,2,4]
Example 2:


Input: head = [2,1,3,5,6,4,7]
Output: [2,3,6,7,1,5,4]
 

Constraints:

The number of nodes in the linked list is in the range [0, 104].
-106 <= Node.val <= 106


*/

// Definition for singly-linked list.
class ListNode {
  int val;
  ListNode? next;
  ListNode([this.val = 0, this.next]);
}

class A {
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

class B {
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

class C {
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
