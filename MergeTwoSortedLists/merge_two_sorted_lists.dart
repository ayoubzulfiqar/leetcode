/*


-* Merge Two Sorted Lists *-


You are given the heads of two sorted linked lists list1 and list2.

Merge the two lists in a one sorted list. The list should be made by
splicing together the nodes of the first two lists.

Return the head of the merged linked list.


Example 1:


Input: list1 = [1,2,4], list2 = [1,3,4]
Output: [1,1,2,3,4,4]


Example 2:

Input: list1 = [], list2 = []
Output: []



Example 3:

Input: list1 = [], list2 = [0]
Output: [0]


Constraints:

The number of nodes in both lists is in the range [0, 50].
-100 <= Node.val <= 100
Both list1 and list2 are sorted in non-decreasing order.

*/

void main() {}

// Definition for singly-linked list.
class ListNode {
  int val;
  ListNode? next;
  ListNode([this.val = 0, this.next]);
}

class A {
  ListNode? mergeTwoLists(ListNode? list1, ListNode? list2) {
    if (list1 == null)
      return list2;
    else if (list2 == null) return list1;

    ListNode res = ListNode(-1);
    if (list1.val < list2.val) {
      res.next = list1;
      list1 = list1.next;
    } else {
      res.next = list2;
      list2 = list2.next;
    }
    ListNode? ptr = res.next;
    while (list1 != null && list2 != null) {
      if (list1.val < list2.val) {
        ptr?.next = list1;
        ptr = ptr?.next;
        list1 = list1.next;
      } else {
        ptr?.next = list2;
        ptr = ptr?.next;
        list2 = list2.next;
      }
    }
    while (list1 != null) {
      ptr?.next = list1;
      ptr = ptr?.next;
      list1 = list1.next;
    }
    while (list2 != null) {
      ptr?.next = list2;
      ptr = ptr?.next;
      list2 = list2.next;
    }
    return res.next;
  }

  /*

  Runtime: 361 ms, faster than 100.00% of Dart online submissions for Merge Two Sorted Lists.
  Memory Usage: 143.5 MB, less than 100.00% of Dart online submissions for Merge Two Sorted Lists.

   */
}

class B {
// 208 / 208 test cases passed, but took too long.

  ListNode? mergeTwoLists(ListNode? list1, ListNode? list2) {
    List<int>? listMerged = <int>[];

    while (list1 != null) {
      listMerged.add(list1.val);
      list1 = list1.next;
    }

    while (list2 != null) {
      listMerged.add(list2.val);
      list2 = list2.next;
    }

    listMerged.sort();

    ListNode? linkedListMerged = ListNode();
    ListNode head = linkedListMerged;

    for (var i in listMerged) {
      linkedListMerged?.next = ListNode(i);
      linkedListMerged = linkedListMerged?.next;
    }

    return head.next;
  }
}

class C {
  // in Node List we have two things one is head which always at
  // the first and tail which always at the end.

  ListNode? head, tail;
  ListNode? mergeTwoLists(ListNode? list1, ListNode? list2) {
    // checking if the first list value is empty if  it is than we will return the value of the another
    // list and vice versa
    if (list1 == null)
      return list2;
    else if (list2 == null) return list1;

// to store the values of the two lists in another ListNode variable
    ListNode? temp1 = list1;
    ListNode? temp2 = list2;

    // while both are not null  like if we don't enter the null values
    while (temp1 != null && temp2 != null) {
      // and if the first value is larger than the second in a nodeList
      if (temp1.val > temp2.val) {
        // than we will insert the second nodeList value first because
        // as written in the question we also have to arrange the values
        insertNode(temp2.val);
        // than second nodeValue will be our next value
        temp2 = temp2.next;
      } else {
        // if it is  not larger than we will use this condition
        // smaller will will always say at first
        insertNode(temp1.val);
        temp1 = temp1.next;
      }
    }
    // condition if we don't enter the null values
    // than we will set the next value of both nodes into the nodeList
    if (temp1 != null) tail?.next = temp1;
    if (temp2 != null) tail?.next = temp2;
    // return the head
    return head;
  }

  void insertNode(int val) {
    //  than we will insert the node and set it values
    ListNode node = ListNode(val);
    if (head == null)
      head = tail = node;
    else {
      tail?.next = node;
      tail = node;
    }
  }

  /*

  Runtime: 429 ms, faster than 100.00% of Dart online submissions for Merge Two Sorted Lists.
  Memory Usage: 143.8 MB, less than 100.00% of Dart online submissions for Merge Two Sorted Lists.

   */
}

class D {
  ListNode? mergeTwoLists(ListNode? list1, ListNode? list2) {
    // if one of them is null  return another  one of the lists
    if (list1 == null) return list2;
    if (list2 == null) return list1;

//
    ListNode? answer = null;
    if (list1.val > list2.val) {
      answer = list2;
      list2 = list2.next;
    } else {
      answer = list1;
      list1 = list1.next;
    }
    ListNode? current = answer;

    while (list1 != null && list2 != null) {
      if (list1.val > list2.val) {
        current?.next = list2;
        list2 = list2.next;
      } else {
        current?.next = list1;
        list1 = list1.next;
      }
      current = current?.next;
    }

    if (list1 == null) {
      current?.next = list2;
    }
    if (list2 == null) {
      current?.next = list1;
    }

    return answer;
  }

  /*

  Runtime: 443 ms, faster than 100.00% of Dart online submissions for Merge Two Sorted Lists.
  Memory Usage: 143.7 MB, less than 100.00% of Dart online submissions for Merge Two Sorted Lists.
   */
}
