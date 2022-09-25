# 🔥 Dart 🔥| simple fast easy and linear solution

## Solution - 1

```dart
class MyCircularQueue {
// Runtime: 512 ms, faster than 100.00% of Dart online submissions for Design Circular Queue.
// Memory Usage: 151.6 MB, less than 50.00% of Dart online submissions for Design Circular Queue.
  // MyCircularQueue
  late List<int> a;
  int front = 0;
  int rear = -1;
  int len = 0;
  MyCircularQueue(int k) {
    this.a = [k];
    a = List.filled(k, 0);
    this.front;
    this.rear;
    this.len;
  }

  bool enQueue(int value) {
    if (!isFull()) {
      if (++rear == a.length) rear = 0;
      a[rear] = value;
      len++;
      return true;
    } else
      return false;
  }

  bool deQueue() {
    if (!isEmpty()) {
      if (++front == a.length) front = 0;
      len--;
      return true;
    } else
      return false;
  }

  int Front() {
    return isEmpty() ? -1 : a[front];
  }

  int Rear() {
    return isEmpty() ? -1 : a[rear];
  }

  bool isEmpty() {
    return len == 0;
  }

  bool isFull() {
    return len == a.length;
  }
}
```

## Solution - 2

```dart
class MyCircularQueue {
  // Runtime: 620 ms, faster than 50.00% of Dart online submissions for Design Circular Queue.
  // Memory Usage: 151.7 MB, less than 50.00% of Dart online submissions for Design Circular Queue.
  int front = -1;
  int rear = -1;
  late List<int> arr;
  int cap = 0;
  MyCircularQueue(int k) {
    arr = List.filled(k, 0);
    front;
    cap = k;
    rear;
  }
  int next(int i) {
    // to get next idx after i in circular queue
    return (i + 1) % cap;
  }

  int prev(int i) {
    // to get prev idx before i in circular queue
    return (i + cap - 1) % cap;
  }

  bool enQueue(int value) {
    if (isFull()) return false;
    if (front == -1) {
      front = 0;
      rear = 0;
      arr[rear] = value;
      return true;
    }
    rear = next(rear);
    arr[rear] = value;
    return true;
  }

  bool deQueue() {
    if (isEmpty()) return false;
    if (front == rear) {
      front = -1;
      rear = -1;
      return true;
    }
    front = next(front);
    return true;
  }

  int Front() {
    if (front == -1) return -1;
    return arr[front];
  }

  int Rear() {
    if (rear == -1) return -1;
    return arr[rear];
  }

  bool isEmpty() {
    return front == -1;
  }

  bool isFull() {
    return front != -1 && next(rear) == front;
  }
}
```

## Solution - 3 Using LinkedList

```dart
class ListNode {
  late int val;
  ListNode? prev, next;
  ListNode(int x) {
    val = x;
    prev = null;
    next = null;
  }
}
```

```dart
class MyCircularQueue {
// Runtime: 644 ms, faster than 50.00% of Dart online submissions for Design Circular Queue.
// Memory Usage: 153.5 MB, less than 50.00% of Dart online submissions for Design Circular Queue.
  late int queueSize, currSize;
  late ListNode head, tail;
  // MyCircularQueue
  MyCircularQueue(int k) {
    queueSize = k;
    currSize = 0;
    head = ListNode(-1);
    tail = ListNode(-1);
    head.next = tail;
    tail.prev = head;
  }

  bool enQueue(int value) {
    if (isFull()) {
      return false;
    }
    ListNode newNode = new ListNode(value);
    newNode.next = tail;
    newNode.prev = tail.prev;
    tail.prev!.next = newNode;
    tail.prev = newNode;
    currSize++;
    return true;
  }

  bool deQueue() {
    if (isEmpty()) {
      return false;
    }
    ListNode? toBeDeleted = head.next;
    head.next = toBeDeleted!.next;
    toBeDeleted.next!.prev = head;
    toBeDeleted.next = null;
    toBeDeleted.prev = null;
    currSize--;
    return true;
  }

  int Front() {
    if (isEmpty()) {
      return -1;
    }
    return head.next!.val;
  }

  int Rear() {
    if (isEmpty()) {
      return -1;
    }
    return tail.prev!.val;
  }

  bool isEmpty() {
    return currSize == 0;
  }

  bool isFull() {
    return currSize == queueSize;
  }
}

```
