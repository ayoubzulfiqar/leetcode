# A

## Solution - 1 Using Doubly Linked LIST

```dart
import 'dart:collection';

class Node {
  late int key;
  late int val;
  late Node next;
  late Node prev;
  int freq = 1;
  Node(int k, int v) {
    key = k;
    val = v;
  }
}

class DoublyLinkedList {
  late Node head;
  late Node tail;
  DoublyLinkedList() {
    head = Node(-1, -1);
    tail = Node(-1, -1);
    head.next = tail;
    tail.prev = head;
  }
  void addNode(Node v) {
    Node next = head.next;
    head.next = v;
    v.prev = head;
    head.next = v;
    v.next = next;
    next.prev = v;
  }

  Node removeNode() {
    Node node = tail.prev;
    node.prev.next = tail;
    tail.prev = node.prev;
    return node;
  }

  Node removeNodeAt(Node v) {
    Node prev = v.prev;
    Node next = v.next;
    prev.next = next;
    next.prev = prev;
    return v;
  }

  bool isEmpty() {
    if (head.next == tail) return true;
    return false;
  }
}

class LFUCache {
  HashMap<int, DoublyLinkedList> freqList = HashMap<int, DoublyLinkedList>();
  HashMap<int, Node> lfuCache = HashMap<int, Node>();
  late int capacity;
  late int minFreq;
  LFUCache(int capacity) {
    this.capacity = capacity;
    minFreq = 1;
  }

  int get(int key) {
    if (lfuCache[key] == null) return -1;
    Node v = lfuCache[key] ?? 0 as Node;
    freqList[v.freq]?.removeNodeAt(v);
    if (freqList[v.freq]!.isEmpty()) {
      if (minFreq == v.freq) {
        minFreq = v.freq + 1;
      }
    }
    v.freq += 1;
    if (freqList[v.freq] == null) {
      DoublyLinkedList d = new DoublyLinkedList();
      d.addNode(v);
      freqList[v.freq] = d;
    } else {
      freqList[v.freq]?.addNode(v);
    }
    return v.val;
  }

  void put(int key, int value) {
    if (capacity == 0) return;
    if (lfuCache[key] != null) {
      Node v = lfuCache[key] ?? 0 as Node;
      freqList[v.freq]?.removeNodeAt(v);
      if (freqList[v.freq]!.isEmpty()) {
        if (minFreq == v.freq) minFreq = v.freq + 1;
      }
      v.freq += 1;
      if (freqList[v.freq] == null) {
        DoublyLinkedList d = new DoublyLinkedList();
        d.addNode(v);
        freqList[v.freq] = d;
      } else {
        freqList[v.freq]?.addNode(v);
      }
      v.val = value;
    } else {
      if (lfuCache.length == capacity) {
        Node v = freqList[minFreq]!.removeNode();
        lfuCache.remove(v.key);
      }
      Node newNode = new Node(key, value);
      lfuCache[key] = newNode;
      if (freqList[1] != null) {
        freqList[1]?.addNode(newNode);
      } else {
        DoublyLinkedList d = new DoublyLinkedList();
        d.addNode(newNode);
        freqList[1] = d;
      }
      minFreq = 1;
    }
  }
}
```
