#

## 1

```dart
class Solution {
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
```

## 2

```dart

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
            final ListNode delete2 = current.next!;
            nextNode = delete2.next!;
            prevNode.next = nextNode;
            nextNode.prev = prevNode;
            current = prevNode;
          } else if (nextNode.val > current.val) {
            final ListNode prevNode = current.prev!;
            prevNode.next = nextNode;
            nextNode.prev = prevNode;
            if (prevNode.pos)
              current = current.prev!;
            else
              current = current.next!;
          } else {
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
```
