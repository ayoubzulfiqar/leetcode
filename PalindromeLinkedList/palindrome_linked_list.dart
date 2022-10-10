/*



-* Palindrome Linked List *-

Given the head of a singly linked list, return true if it is a palindrome or false otherwise.



Example 1:


Input: head = [1,2,2,1]
Output: true
Example 2:


Input: head = [1,2]
Output: false


Constraints:

The number of nodes in the list is in the range [1, 105].
0 <= Node.val <= 9


Follow up: Could you do it in O(n) time and O(1) space?

*/

// Definition for singly-linked list.
class ListNode {
  int val;
  ListNode? next;
  ListNode([this.val = 0, this.next]);
}

class A {
  bool isPalindrome(ListNode? head) {
    // to store the values
    List<int> array = [];
    // if there is value we will add into our list
    if (head != null) {
      array.add(head.val);
      // pointing it to the next value
      head = head.next;
    }
    // now all the values is inside the list so let's work on list
    // - pointer on the lift value
    int left = 0;
    // pointer on the right value
    int right = array.length - 1;
    // assuming that he value on left side is less than the right side
    while (left < right) {
      // reading forward values from left side via ++
      // reading it backward values via --

      // from forward to backward are not same than  it's not palindrome
      if (array[left++] != array[right--]) return false;
    }
    return true;
  }
}

class B {
// Runtime: 628 ms, faster than 51.02% of Dart online submissions for Palindrome Linked List.
// Memory Usage: 194.6 MB, less than 69.39% of Dart online submissions for Palindrome Linked List.
  bool isPalindrome(ListNode? head) {
    // if everything is null than it's true means no value available
    if (head == null || head.next == null) return true;

    // first value on the head
    int first = head.val;
    // second value both needs to compare
    int second = head.val;
    // multiplier
    int currentMultiplier = 10;
    // while nothing is null means we have values
    while ((head = head?.next) != null) {
      // simple multiplication and summation
      first = (first * 10) + head!.val;
      second = second + (currentMultiplier * head.val);
      currentMultiplier *= 10;
    }

    // if both are same boom Congratulation
    return first == second;
  }
}

class C {
// Runtime: 595 ms, faster than 63.27% of Dart online submissions for Palindrome Linked List.
// Memory Usage: 194.5 MB, less than 69.39% of Dart online submissions for Palindrome Linked List.
  ListNode reverseLL(ListNode head) {
    ListNode? prev = null, next = null, cur = head;
    while (cur != null) {
      // creating duplicate of every node during iteration
      ListNode temp = new ListNode(cur.val, cur.next);

      // swapping prev & next of 'temp' node
      next = temp.next;
      temp.next = prev;
      prev = temp;
      cur = next; // moving ahead in original LL
    }
    return prev!;
  }

  bool isPalindrome(ListNode? head) {
    ListNode? tail = reverseLL(head!); // got the head of reversed LL

    while (head != null) {
      if (head.val != tail?.val) return false;
      head = head.next;
      tail = tail?.next;
    }
    return true;
  }
}

class Solution {
  bool isPalindrome(ListNode? head) {
    ListNode? temp = head;

    ListNode? midNode = getMiddle(temp!);
    ListNode? tail = reverseLL(midNode);

    while (tail != null) {
      if (tail.val != head?.val) return false;
      tail = tail.next;
      head = head?.next;
    }
    return true;
  }

  ListNode getMiddle(ListNode head) {
    // using tortoise-hare method to find middle element
    ListNode? prevTort = null, tort = head, hare = head;
    while (hare != null && hare.next != null) {
      prevTort = tort;
      tort = tort?.next;
      hare = hare.next?.next;
    }
    if (tort != null) // case when LL is of odd length
      return tort;
    return prevTort!; // case of even length we'll get 2 mid. So, returning 1st mid node.
  }

  ListNode reverseLL(ListNode head) {
    ListNode? prev = null, next = null, cur = head;
    while (cur != null) {
      next = cur.next;
      cur.next = prev;
      prev = cur;
      cur = next;
    }
    return prev!;
  }
}
