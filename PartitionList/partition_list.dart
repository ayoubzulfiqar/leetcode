/*

-* 86. Partition List *-


Given the head of a linked list and a value x, partition it such that all nodes less than x come before nodes greater than or equal to x.

You should preserve the original relative order of the nodes in each of the two partitions.

 

Example 1:


Input: head = [1,4,3,2,5,2], x = 3
Output: [1,2,2,4,3,5]
Example 2:

Input: head = [2,1], x = 2
Output: [1,2]
 

Constraints:

The number of nodes in the list is in the range [0, 200].
-100 <= Node.val <= 100
-200 <= x <= 200



*/

// Definition for singly-linked list.
class ListNode {
  int val;
  ListNode? next;
  ListNode([this.val = 0, this.next]);
}

class Solution {
  ListNode? partition(ListNode? head, int x) {
    ListNode left = ListNode(0);
    ListNode right = ListNode(0);
    ListNode temp1 = left;
    ListNode temp2 = right;

    while (head != null) {
      if (head.val < x) {
        left.next = head;
        left = left.next!;
      } else {
        right.next = head;
        right = right.next!;
      }
      head = head.next;
    }

    left.next = temp2.next;
    right.next = null;

    return temp1.next;
  }
}

class MERGESort {
  ListNode? merge(ListNode? firstList, ListNode? secondList, int x) {
    if (firstList == null) {
      return secondList;
    }
    if (secondList == null) {
      return firstList;
    }

    ListNode newHead = ListNode(-9);
    ListNode temp = newHead;

    while (firstList != null && secondList != null) {
      if (firstList.val < x) {
        temp.next = firstList;
        firstList = firstList.next;
      } else if (secondList.val < x) {
        temp.next = secondList;
        secondList = secondList.next;
      } else {
        break;
      }
      temp = temp.next!;
    }

    if (firstList != null) {
      temp.next = firstList;
      while (temp.next != null) {
        temp = temp.next!;
      }
    }

    if (secondList != null) {
      temp.next = secondList;
    }

    return newHead.next;
  }

  ListNode? partition(ListNode? head, int x) {
    if (head == null || head.next == null) {
      return head;
    }

    ListNode? temp = head;
    ListNode? slow = head.next;
    ListNode? fast = slow?.next;

    while (fast != null && fast.next != null) {
      temp = slow;
      slow = slow?.next;
      fast = fast.next?.next;
    }

    temp?.next = null;

    return merge(partition(head, x), partition(slow, x), x);
  }
}
