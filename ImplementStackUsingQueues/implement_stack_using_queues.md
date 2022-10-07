# 🔥 Implement Stack using Queues 🔥 || 3 Solutions || Simple Fast and Easy || with Explanation

## Solution - 1 Single Queue

```dart
import 'dart:collection';

class MyStack {
// Runtime: 467 ms, faster than 50.00% of Dart online submissions for Implement Stack using Queues.
// Memory Usage: 143 MB, less than 75.00% of Dart online submissions for Implement Stack using Queues.
  Queue<int> queue = Queue();

  MyStack() {
    this.queue;
  }

  void push(int x) {
    queue.add(x);
    for (int i = 0; i < queue.length - 1; i++) {
      queue.add(queue.removeFirst());
    }
  }

  int pop() {
    return queue.removeFirst();
  }

  int top() {
    return queue.first;
  }

  bool empty() {
    return queue.isEmpty;
  }
}
```

## Solution - 2 Double Queue

```dart
import 'dart:collection';

class MyStack {
// Runtime: 469 ms, faster than 50.00% of Dart online submissions for Implement Stack using Queues.
// Memory Usage: 143 MB, less than 50.00% of Dart online submissions for Implement Stack using Queues.

  Queue<int> queueOne = Queue();
  Queue<int> queueTwo = Queue();
  MyStack() {
    this.queueOne;
    this.queueTwo;
  }

  void push(int x) {
    if (queueOne.isEmpty && queueTwo.isEmpty) {
      queueOne.add(x);
    } else if (queueOne.isEmpty) {
      queueOne.add(x);
      while (queueTwo.isNotEmpty) {
        queueOne.add(queueTwo.removeFirst());
      }
    } else if (queueTwo.isEmpty) {
      queueTwo.add(x);
      while (queueOne.isNotEmpty) {
        queueTwo.add(queueOne.removeFirst());
      }
    }
  }

  int pop() {
    if (queueOne.isNotEmpty) {
      return queueOne.removeFirst();
    } else if (queueTwo.isNotEmpty)
      return queueTwo.removeFirst();
    else
      return -1;
  }

  int top() {
    if (queueOne.isNotEmpty) {
      return queueOne.first;
    } else if (queueTwo.isNotEmpty)
      return queueTwo.first;
    else
      return -1;
  }

  bool empty() {
    return queueTwo.isEmpty && queueOne.isEmpty;
  }
}
```

## Bonus Solution - Go 😈

```go
type MyStack struct {
    queue []int
}


/** Initialize your data structure here. */
func Constructor() MyStack {
    return MyStack{ []int{} }
}


/** Push element x onto stack. */
func (this *MyStack) Push(x int)  {
    this.queue = append(this.queue[:0], append([]int{x}, this.queue[0:]...)...) // prepend
}


/** Removes the element on top of the stack and returns that element. */
func (this *MyStack) Pop() int {
    temp := this.queue[0]
    this.queue = this.queue[1:]
    return temp
}


/** Get the top element. */
func (this *MyStack) Top() int {
    return this.queue[0]
}


/** Returns whether the stack is empty. */
func (this *MyStack) Empty() bool {
    return len(this.queue) == 0
}
```
