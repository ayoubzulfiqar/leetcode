/*

 -* Delete the Middle Node of a Linked List *-

You are given the head of a linked list. Delete the middle node, and return the head of the modified linked list.

The middle node of a linked list of size n is the ⌊n / 2⌋th node from the start using 0-based indexing, where ⌊x⌋ denotes the largest integer less than or equal to x.

For n = 1, 2, 3, 4, and 5, the middle nodes are 0, 1, 1, 2, and 2, respectively.


Example 1:


Input: head = [1,3,4,7,1,2,6]
Output: [1,3,4,1,2,6]
Explanation:
The above figure represents the given linked list. The indices of the nodes are written below.
Since n = 7, node 3 with value 7 is the middle node, which is marked in red.
We return the new list after removing this node.
Example 2:


Input: head = [1,2,3,4]
Output: [1,2,4]
Explanation:
The above figure represents the given linked list.
For n = 4, node 2 with value 3 is the middle node, which is marked in red.
Example 3:


Input: head = [2,1]
Output: [2]
Explanation:
The above figure represents the given linked list.
For n = 2, node 1 with value 1 is the middle node, which is marked in red.
Node 0 with value 2 is the only node remaining after removing node 1.


Constraints:

The number of nodes in the list is in the range [1, 105].
1 <= Node.val <= 105


*/

// Definition for singly-linked list.
class ListNode {
  int val;
  ListNode? next;
  ListNode([this.val = 0, this.next]);
}

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

// Optimized Solution TC: O(n) SC: O(1)
class B {
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

// Brute Force Solution : Calculate Size TC: O(n) SC: O(1)
class C {
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
