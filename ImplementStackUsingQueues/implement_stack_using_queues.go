package main

// // Runtime: 0 ms, faster than 100.00% of Go online submissions for Implement Stack using Queues.
// // Memory Usage: 1.9 MB, less than 82.31% of Go online submissions for Implement Stack using Queues.
// /*
// type MyStack struct {
// 	queue []int
// }

// /** Initialize your data structure here. */
// func Constructor() MyStack {
// 	return MyStack{[]int{}}
// }

// /** Push element x onto stack. */
// func (this *MyStack) Push(x int) {
// 	this.queue = append(this.queue[:0], append([]int{x}, this.queue[0:]...)...) // prepend
// }

// /** Removes the element on top of the stack and returns that element. */
// func (this *MyStack) Pop() int {
// 	temp := this.queue[0]
// 	this.queue = this.queue[1:]
// 	return temp
// }

// /** Get the top element. */
// func (this *MyStack) Top() int {
// 	return this.queue[0]
// }

// /** Returns whether the stack is empty. */
// func (this *MyStack) Empty() bool {
// 	return len(this.queue) == 0
// }

type MyStack struct {
	top   int
	stack [100]int
}

func Constructor() MyStack {
	return MyStack{
		top:   -1,
		stack: [100]int{},
	}
}

func (this *MyStack) Push(x int) {
	this.top++
	this.stack[this.top] = x
}

func (this *MyStack) Pop() int {
	var temp int = this.stack[this.top]
	this.top--
	return temp
}

func (this *MyStack) Top() int {
	return this.stack[this.top]
}

func (this *MyStack) Empty() bool {
	return this.top == -1
}
