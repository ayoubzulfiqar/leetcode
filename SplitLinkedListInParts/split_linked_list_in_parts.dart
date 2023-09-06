/*

-* 725. Split Linked List in Parts *-


Given the head of a singly linked list and an integer k, split the linked list into k consecutive linked list parts.

The length of each part should be as equal as possible: no two parts should have a size differing by more than one. This may lead to some parts being null.

The parts should be in the order of occurrence in the input list, and parts occurring earlier should always have a size greater than or equal to parts occurring later.

Return an array of the k parts.

 

Example 1:


Input: head = [1,2,3], k = 5
Output: [[1],[2],[3],[],[]]
Explanation:
The first element output[0] has output[0].val = 1, output[0].next = null.
The last element output[4] is null, but its string representation as a ListNode is [].
Example 2:


Input: head = [1,2,3,4,5,6,7,8,9,10], k = 3
Output: [[1,2,3,4],[5,6,7],[8,9,10]]
Explanation:
The input has been split into consecutive parts with size difference at most 1, and earlier parts are a larger size than the later parts.
 

Constraints:

The number of nodes in the list is in the range [0, 1000].
0 <= Node.val <= 1000
1 <= k <= 50

*/

//  Definition for singly-linked list.
class ListNode {
  int val;
  ListNode? next;
  ListNode([this.val = 0, this.next]);
}

class Solution {
  List<ListNode?> splitListToParts(ListNode? head, int k) {
    ListNode? current = head;
    final List<ListNode?> answer = List<ListNode?>.filled(k, null);
    int ptr = 0;
    int listLength = 0;

    // Calculate the length of the linked list
    while (current != null) {
      listLength++;
      current = current.next;
    }

    // Calculate the extra elements in some parts
    int extra = listLength % k;
    // Calculate the base length for each part
    final int partLength = listLength ~/ k;
    current = head;

    while (current != null) {
      answer[ptr++] = current;
      // Calculate the length of the current part
      int currentLength = partLength - 1 + ((extra-- > 0) ? 1 : 0);

      // Move the current pointer to the end of the current part
      for (int i = 0; i < currentLength; i++) current = current?.next;

      // Disconnect the current part from the next part
      ListNode? temp = current?.next;
      current?.next = null;
      current = temp;
    }
    return answer;
  }
}
