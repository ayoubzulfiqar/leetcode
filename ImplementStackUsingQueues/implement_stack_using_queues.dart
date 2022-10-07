/*

 -* Implement Stack using Queues *-

Implement a last-in-first-out (LIFO) stack using only two queues. The implemented stack should support all the functions of a normal stack (push, top, pop, and empty).

Implement the MyStack class:

void push(int x) Pushes element x to the top of the stack.
int pop() Removes the element on the top of the stack and returns it.
int top() Returns the element on the top of the stack.
boolean empty() Returns true if the stack is empty, false otherwise.
Notes:

You must use only standard operations of a queue, which means that only push to back, peek/pop from front, size and is empty operations are valid.
Depending on your language, the queue may not be supported natively. You may simulate a queue using a list or deque (double-ended queue) as long as you use only a queue's standard operations.


Example 1:

Input
["MyStack", "push", "push", "top", "pop", "empty"]
[[], [1], [2], [], [], []]
Output
[null, null, null, 2, 2, false]

Explanation
MyStack myStack = new MyStack();
myStack.push(1);
myStack.push(2);
myStack.top(); // return 2
myStack.pop(); // return 2
myStack.empty(); // return False


Constraints:

1 <= x <= 9
At most 100 calls will be made to push, pop, top, and empty.
All the calls to pop and top are valid.


Follow-up: Can you implement the stack using only one queue?


*/

import 'dart:collection';

// Runtime: 469 ms, faster than 50.00% of Dart online submissions for Implement Stack using Queues.
// Memory Usage: 143 MB, less than 50.00% of Dart online submissions for Implement Stack using Queues.

class MyStack {
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

/*

class MyStack {

  MyStack() {

  }

  void push(int x) {

  }

  int pop() {

  }

  int top() {

  }

  bool empty() {

  }
}

*/
class MyStacking {
// Runtime: 467 ms, faster than 50.00% of Dart online submissions for Implement Stack using Queues.
// Memory Usage: 143 MB, less than 75.00% of Dart online submissions for Implement Stack using Queues.
  Queue<int> queue = Queue();

  MyStacking() {
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
