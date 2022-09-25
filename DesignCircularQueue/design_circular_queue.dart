/*


-* Design a Circle Queue *-



Design your implementation of the circular queue.
The circular queue is a linear data structure in which the operations are performed based on FIFO (First In First Out)
principle and the last position is connected back to the first position to make a circle. It is also called "Ring Buffer".

One of the benefits of the circular queue is that we can make use of the spaces in front of the queue.
In a normal queue, once the queue becomes full, we cannot insert the next element even if there is a space in front of the queue.
But using the circular queue, we can use the space to store new values.

Implementation the MyCircularQueue class:

MyCircularQueue(k) Initializes the object with the size of the queue to be k.
int Front() Gets the front item from the queue. If the queue is empty, return -1.
int Rear() Gets the last item from the queue. If the queue is empty, return -1.
boolean enQueue(int value) Inserts an element into the circular queue. Return true if the operation is successful.
boolean deQueue() Deletes an element from the circular queue. Return true if the operation is successful.
boolean isEmpty() Checks whether the circular queue is empty or not.
boolean isFull() Checks whether the circular queue is full or not.
You must solve the problem without using the built-in queue data structure in your programming language.



Example 1:

Input
["MyCircularQueue", "enQueue", "enQueue", "enQueue", "enQueue", "Rear", "isFull", "deQueue", "enQueue", "Rear"]
[[3], [1], [2], [3], [4], [], [], [], [4], []]
Output
[null, true, true, true, false, 3, true, true, true, 4]

Explanation
MyCircularQueue myCircularQueue = new MyCircularQueue(3);
myCircularQueue.enQueue(1); // return True
myCircularQueue.enQueue(2); // return True
myCircularQueue.enQueue(3); // return True
myCircularQueue.enQueue(4); // return False
myCircularQueue.Rear();     // return 3
myCircularQueue.isFull();   // return True
myCircularQueue.deQueue();  // return True
myCircularQueue.enQueue(4); // return True
myCircularQueue.Rear();     // return 4


Constraints:

1 <= k <= 1000
0 <= value <= 1000
At most 3000 calls will be made to enQueue, deQueue, Front, Rear, isEmpty, and isFull.




*/

/*
 *
 * Your MyCircularQueue object will be instantiated and called as such:
 * MyCircularQueue obj = MyCircularQueue(k);
 * bool param1 = obj.enQueue(value);
 * bool param2 = obj.deQueue();
 * int param3 = obj.Front();
 * int param4 = obj.Rear();
 * bool param5 = obj.isEmpty();
 * bool param6 = obj.isFull();
 *
 */

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

class MyCircularQueue1 {
  // Runtime: 620 ms, faster than 50.00% of Dart online submissions for Design Circular Queue.
  // Memory Usage: 151.7 MB, less than 50.00% of Dart online submissions for Design Circular Queue.
  int front = -1;
  int rear = -1;
  late List<int> arr;
  int cap = 0;
  MyCircularQueue1(int k) {
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

class ListNode {
  late int val;
  ListNode? prev, next;
  ListNode(int x) {
    val = x;
    prev = null;
    next = null;
  }
}

class C {
// Runtime: 644 ms, faster than 50.00% of Dart online submissions for Design Circular Queue.
// Memory Usage: 153.5 MB, less than 50.00% of Dart online submissions for Design Circular Queue.
  late int queueSize, currSize;
  late ListNode head, tail;
  // MyCircularQueue
  C(int k) {
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
