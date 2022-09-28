/*

-* Intersection of Two Linked Lists *-


Given the heads of two singly linked-lists headA and headB, return the node at which the two lists intersect. If the two linked lists have no intersection at all, return null.

For example, the following two linked lists begin to intersect at node c1:


The test cases are generated such that there are no cycles anywhere in the entire linked structure.

Note that the linked lists must retain their original structure after the function returns.

Custom Judge:

The inputs to the judge are given as follows (your program is not given these inputs):

intersectVal - The value of the node where the intersection occurs. This is 0 if there is no intersected node.
listA - The first linked list.
listB - The second linked list.
skipA - The number of nodes to skip ahead in listA (starting from the head) to get to the intersected node.
skipB - The number of nodes to skip ahead in listB (starting from the head) to get to the intersected node.
The judge will then create the linked structure based on these inputs and pass the two heads, headA and headB to your program. If you correctly return the intersected node, then your solution will be accepted.



Example 1:


Input: intersectVal = 8, listA = [4,1,8,4,5], listB = [5,6,1,8,4,5], skipA = 2, skipB = 3
Output: Intersected at '8'
Explanation: The intersected node's value is 8 (note that this must not be 0 if the two lists intersect).
From the head of A, it reads as [4,1,8,4,5]. From the head of B, it reads as [5,6,1,8,4,5]. There are 2 nodes before the intersected node in A; There are 3 nodes before the intersected node in B.
- Note that the intersected node's value is not 1 because the nodes with value 1 in A and B (2nd node in A and 3rd node in B) are different node references. In other words, they point to two different locations in memory, while the nodes with value 8 in A and B (3rd node in A and 4th node in B) point to the same location in memory.
Example 2:


Input: intersectVal = 2, listA = [1,9,1,2,4], listB = [3,2,4], skipA = 3, skipB = 1
Output: Intersected at '2'
Explanation: The intersected node's value is 2 (note that this must not be 0 if the two lists intersect).
From the head of A, it reads as [1,9,1,2,4]. From the head of B, it reads as [3,2,4]. There are 3 nodes before the intersected node in A; There are 1 node before the intersected node in B.
Example 3:


Input: intersectVal = 0, listA = [2,6,4], listB = [1,5], skipA = 3, skipB = 2
Output: No intersection
Explanation: From the head of A, it reads as [2,6,4]. From the head of B, it reads as [1,5]. Since the two lists do not intersect, intersectVal must be 0, while skipA and skipB can be arbitrary values.
Explanation: The two lists do not intersect, so return null.


Constraints:

The number of nodes of listA is in the m.
The number of nodes of listB is in the n.
1 <= m, n <= 3 * 104
1 <= Node.val <= 105
0 <= skipA < m
0 <= skipB < n
intersectVal is 0 if listA and listB do not intersect.
intersectVal == listA[skipA] == listB[skipB] if listA and listB intersect.


Follow up: Could you write a solution that runs in O(m + n) time and use only O(1) memory?


*/

import 'dart:collection';

class ListNode {
  int val;
  ListNode? next;
  ListNode([this.val = 0, this.next]);
}

class A {
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

class B {
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

class C {
  ListNode? getIntersectionNode(ListNode? headA, headB) {
    if (headA == null || headB == null) return null;

    ListNode? a = headA;
    ListNode? b = headB;

    //if a & b have different len, then we will stop the loop after second iteration
    while (a != b) {
      //for the end of first iteration, we just reset the pointer to the head of another linkedlist
      a = a == null ? headB : a.next;
      b = b == null ? headA : b.next;
    }

    return a;
  }
}

class D {
  // O(m+n)
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
