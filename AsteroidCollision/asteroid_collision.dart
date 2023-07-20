/*


-* 735. Asteroid Collision *-

We are given an array asteroids of integers representing asteroids in a row.

For each asteroid, the absolute value represents its size, and the sign represents its direction (positive meaning right, negative meaning left). Each asteroid moves at the same speed.

Find out the state of the asteroids after all collisions. If two asteroids meet, the smaller one will explode. If both are the same size, both will explode. Two asteroids moving in the same direction will never meet.

 

Example 1:

Input: asteroids = [5,10,-5]
Output: [5,10]
Explanation: The 10 and -5 collide resulting in 10. The 5 and 10 never collide.
Example 2:

Input: asteroids = [8,-8]
Output: []
Explanation: The 8 and -8 collide exploding each other.
Example 3:

Input: asteroids = [10,2,-5]
Output: [10]
Explanation: The 2 and -5 collide resulting in -5. The 10 and -5 collide resulting in 10.
 

Constraints:

2 <= asteroids.length <= 104
-1000 <= asteroids[i] <= 1000
asteroids[i] != 0



*/

// Iteration
class A {
  List<int> asteroidCollision(List<int> asteroids) {
    final int n = asteroids.length;
    int j = 0;

    for (int i = 0; i < n; i++) {
      final int asteroid = asteroids[i];
      while (j > 0 &&
          asteroids[j - 1] > 0 &&
          asteroid < 0 &&
          asteroids[j - 1] < asteroid.abs()) {
        j--;
      }

      if (j == 0 || asteroid > 0 || asteroids[j - 1] < 0) {
        asteroids[j++] = asteroid;
      } else if (asteroids[j - 1] == asteroid.abs()) {
        j--;
      }
    }

    final List<int> result = List<int>.from(asteroids.sublist(0, j));
    return result;
  }
}

// Doubly Linked List

class ListNode {
  int val;
  bool pos;
  ListNode? next;
  ListNode? prev;

  ListNode({this.next, this.prev, this.val = 0, this.pos = false});
}

class Solution {
  List<int> asteroidCollision(List<int> a) {
    final ListNode head = ListNode(pos: false);
    ListNode current = head;

    final int n = a.length;

    for (int i = 0; i < n; ++i) {
      final ListNode node = ListNode(val: a[i].abs(), pos: a[i] > 0);
      current.next = node;
      node.prev = current;
      current = node;
    }

    final ListNode tail = ListNode(pos: true);
    current.next = tail;
    tail.prev = current;

    current = head;
    while (current != tail) {
      if (current.pos) {
        ListNode nextNode = current.next!;
        if (nextNode.pos) {
          current = nextNode;
        } else {
          if (nextNode.val == current.val) {
            final ListNode prevNode = current.prev!;
            // var delete1 = current;
            final ListNode delete2 = current.next!;
            nextNode = delete2.next!;
            prevNode.next = nextNode;
            nextNode.prev = prevNode;
            current = prevNode;
          } else if (nextNode.val > current.val) {
            final ListNode prevNode = current.prev!;
            prevNode.next = nextNode;
            nextNode.prev = prevNode;
            // var toDelete = current;
            if (prevNode.pos)
              current = current.prev!;
            else
              current = current.next!;
          } else {
            // var toDelete = nextNode;
            nextNode = nextNode.next!;
            current.next = nextNode;
            nextNode.prev = current;
          }
        }
      } else {
        current = current.next!;
      }
    }

    final List<int> ans = [];
    current = head.next!;
    while (current != tail) {
      final int value = current.pos ? current.val : -current.val;
      ans.add(value);
      current = current.next!;
    }
    return ans;
  }
}
