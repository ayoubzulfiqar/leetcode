# 🔥 Design Browser History 🔥 || Simple Fast and Easy || with Explanation

## Using List

The current URL is represented by the index "current", which starts at 1 (since the first visited URL is at index 0). The total number of visited URLs is stored in the "total" variable.

The "visit" method adds a new URL to the history by either setting the element at index "current" to the new URL (if there are already visited URLs after the current position), or by adding the new URL to the end of the list. The "current" and "total" variables are updated accordingly.

The "back" method navigates the history backward by decrementing "current" by the specified number of steps, but ensuring that it never goes below 1 (the beginning of the history). The URL at index "current-1" is then returned.

The "forward" method navigates the history forward by incrementing "current" by the specified number of steps, but ensuring that it never goes above the "total" number of visited URLs. The URL at index "current-1" is then returned.

```dart
import 'dart:math';

class BrowserHistory {
  late List<String> list;
  int total = 0;
  int current = 0;
  BrowserHistory(String homepage) {
    list = <String>[];
    list.add(homepage);
    total++;
    current++;
  }

  void visit(String url) {
    if (list.length > current) {
      list[current] = url;
    } else {
      list.add(url);
    }
    current++;
    total = current;
  }

  String back(int steps) {
    current = max(1, current - steps);
    return list.elementAt(current - 1);
  }

  String forward(int steps) {
    current = min(total, current + steps);
    return list.elementAt(current - 1);
  }
}
```

## Using Node - Doubly Linked List

We will create a Node class. Each node in the linked list represents a visited URL, and has a "val" (URL string), "prev" (previous node) and "next" (next node) field.

The "visit" method adds a new URL to the history by creating a new node and setting its "prev" field to the current "root" node, and the "next" field of the current "root" node to the new node. The "root" variable is then updated to point to the new node.

The "back" method navigates the history backward by following the "prev" pointers of nodes until the desired number of steps is reached, or until the beginning of the history is reached. The "root" variable is then updated to point to the current node, and its "val" field is returned.

The "forward" method navigates the history forward by following the "next" pointers of nodes until the desired number of steps is reached, or until the end of the history is reached. The "root" variable is then updated to point to the current node, and its "val" field is returned.

```dart
class Node {
  String? val;
  Node? next;
  Node? prev;
  Node(String s) {
    val = s;
    prev = next = null;
  }
}

class BrowserHistory {
  late Node root;
  BrowserHistory(String homepage) {
    root = Node(homepage);
  }

  void visit(String url) {
    Node node = Node(url);
    root.next = node;
    node.prev = root;
    root = node;
  }

  String back(int steps) {
    Node cur = root;
    while (steps > 0 && cur.prev != null) {
      cur = cur.prev!;
      steps--;
    }
    root = cur;
    return cur.val!;
  }

  String forward(int steps) {
    Node cur = root;
    while (steps > 0 && cur.next != null) {
      cur = cur.next!;
      steps--;
    }
    root = cur;
    return cur.val!;
  }
}
```

### [GitHub Link](https://github.com/ayoubzulfiqar/leetcode)
