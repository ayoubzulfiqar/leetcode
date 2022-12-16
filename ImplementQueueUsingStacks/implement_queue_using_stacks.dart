// /*

//  -* Implement Queue using Stacks *-

//  Implement a first in first out (FIFO) queue using only two stacks. The implemented queue should support all the functions of a normal queue (push, peek, pop, and empty).

// Implement the MyQueue class:

// void push(int x) Pushes element x to the back of the queue.
// int pop() Removes the element from the front of the queue and returns it.
// int peek() Returns the element at the front of the queue.
// boolean empty() Returns true if the queue is empty, false otherwise.
// Notes:

// You must use only standard operations of a stack, which means only push to top, peek/pop from top, size, and is empty operations are valid.
// Depending on your language, the stack may not be supported natively. You may simulate a stack using a list or deque (double-ended queue) as long as you use only a stack's standard operations.

// Example 1:

// Input
// ["MyQueue", "push", "push", "peek", "pop", "empty"]
// [[], [1], [2], [], [], []]
// Output
// [null, null, null, 1, 1, false]

// Explanation
// MyQueue myQueue = new MyQueue();
// myQueue.push(1); // queue is: [1]
// myQueue.push(2); // queue is: [1, 2] (leftmost is front of the queue)
// myQueue.peek(); // return 1
// myQueue.pop(); // return 1, queue is [2]
// myQueue.empty(); // return false

// Constraints:

// 1 <= x <= 9
// At most 100 calls will be made to push, pop, peek, and empty.
// All the calls to pop and peek are valid.

// Follow-up: Can you implement the queue such that each operation is amortized O(1) time complexity? In other words, performing n operations will take overall O(n) time even if one of those operations may take longer.

// */

// // class MyQueue {
// // // Runtime: 571 ms, faster than 7.69% of Dart online submissions for Implement Queue using Stacks.
// // // Memory Usage: 145 MB, less than 15.38% of Dart online submissions for Implement Queue using Stacks.

// //   Queue<int> ins = Queue();
// //   Queue<int> out = Queue();
// //   MyQueue() {
// //     this.ins;
// //     this.out;
// //   }

// //   void push(int x) {
// //     ins.add(x);
// //   }

// //   int pop() {
// //     if (out.isEmpty) while (ins.isNotEmpty) out.add(ins.removeLast());

// //     return out.removeLast();
// //   }

// //   int peek() {
// //     if (out.isEmpty) while (ins.isNotEmpty) out.add(ins.removeLast());
// //     // peek
// //     return out.first;
// //   }

// //   bool empty() {
// //     return ins.isEmpty && out.isEmpty;
// //   }
// // }

// /*

// class MyQueue {

//   MyQueue() {

//   }

//   void push(int x) {

//   }

//   int pop() {

//   }

//   int peek() {

//   }

//   bool empty() {

//   }
// }

// */

// abstract class Stack<T> {
//   // Pushes element to the top of the stack.
//   void push(T value);

//   // Removes the element at the top of the stack and returns it.
//   T pop();

//   // Returns the element at the top of the stack.
//   peek();

//   // Returns true if the stack is empty, false otherwise.
//   bool get isEmpty;
// }

// abstract class Queue<T> {
//   // Pushes element [value] to the back of the queue.
//   void push(T value);

//   // Removes the element from the front of the queue and returns it.
//   T pop();

//   // Returns the element at the front of the queue.
//   T peek();

//   // Returns true if the queue is empty, false otherwise.
//   bool get isEmpty;
// }

// // class CollectionStack<T> implements Stack<T> {
// //   CollectionStack(this._internal);

// //   final c.Queue<T> _internal;

// //   @override
// //   void push(T value) => _internal.addLast(value);

// //   @override
// //   T pop() => _internal.removeLast();

// //   @override
// //   T peek() => _internal.last;

// //   @override
// //   bool get isEmpty => _internal.isEmpty;
// // }

// class DoubleStackQueue<T> implements Queue<T> {
//   DoubleStackQueue(
//     this._pushStack,
//     this._popStack,
//   ) : _phase = _Phase.push;

//   final Stack<T> _pushStack;
//   final Stack<T> _popStack;

//   _Phase _phase;

//   // [phase] is the new phase.
//   void _switchPhase(_Phase phase) {
//     if (_phase == phase) return;
//     if (phase == _Phase.push) {
//       while (!_popStack.isEmpty) _pushStack.push(_popStack.pop());
//     } else {
//       while (!_pushStack.isEmpty) _popStack.push(_pushStack.pop());
//     }
//     _phase = phase;
//   }

//   @override
//   void push(T value) {
//     _switchPhase(_Phase.push);
//     _pushStack.push(value);
//   }

//   @override
//   T pop() {
//     _switchPhase(_Phase.pop);
//     return _popStack.pop();
//   }

//   @override
//   T peek() {
//     _switchPhase(_Phase.pop);
//     return _popStack.peek();
//   }

//   @override
//   bool get isEmpty => _pushStack.isEmpty && _popStack.isEmpty;
// }

// enum _Phase { push, pop }


