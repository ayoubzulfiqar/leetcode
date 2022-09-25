package main

// type MyCircularQueue struct {
// 	slice             []int
// 	front, rear, size int
// }

// func Constructor(k int) MyCircularQueue {
// 	return MyCircularQueue{
// 		size:  k,
// 		slice: make([]int, k),
// 		front: 0,
// 		rear:  -1,
// 	}
// }

// func (q *MyCircularQueue) EnQueue(value int) bool {
// 	if q.IsFull() {
// 		return false
// 	}
// 	q.rear++
// 	q.slice[q.rear%q.size] = value
// 	return true
// }

// func (q *MyCircularQueue) DeQueue() bool {
// 	if q.IsEmpty() {
// 		return false
// 	}
// 	q.front++
// 	return true
// }

// func (q *MyCircularQueue) Front() int {
// 	if q.IsEmpty() {
// 		return -1
// 	}
// 	return q.slice[q.front%q.size]
// }

// func (q *MyCircularQueue) Rear() int {
// 	if q.IsEmpty() {
// 		return -1
// 	}
// 	return q.slice[q.rear%q.size]
// }

// func (q *MyCircularQueue) IsEmpty() bool {
// 	return q.rear < q.front
// }

// func (q *MyCircularQueue) IsFull() bool {
// 	return q.rear-q.front == q.size-1
// }

type MyCircularQueue struct {
	queue []int
	front int
	rear  int
	size  int
}

/** Initialize your data structure here. Set the size of the queue to be k. */
func Constructor(k int) MyCircularQueue {
	return MyCircularQueue{
		queue: make([]int, k),
		front: -1,
		rear:  -1,
		size:  k,
	}
}

/** Insert an element into the circular queue. Return true if the operation is successful. */
func (this *MyCircularQueue) EnQueue(value int) bool {
	if this.IsFull() {
		return false
	}

	this.rear = (this.rear + 1) % this.size
	if this.front == -1 {
		this.front = this.rear
	}
	this.queue[this.rear] = value
	return true
}

/** Delete an element from the circular queue. Return true if the operation is successful. */
func (this *MyCircularQueue) DeQueue() bool {
	if this.IsEmpty() {
		return false
	}

	if this.rear == this.front {
		this.rear = -1
		this.front = -1
	} else {
		this.front = (this.front + 1) % this.size
	}

	return true
}

/** Get the front item from the queue. */
func (this *MyCircularQueue) Front() int {
	if this.IsEmpty() {
		return -1
	}
	return this.queue[this.front]
}

/** Get the last item from the queue. */
func (this *MyCircularQueue) Rear() int {
	if this.IsEmpty() {
		return -1
	}
	return this.queue[this.rear]
}

/** Checks whether the circular queue is empty or not. */
func (this *MyCircularQueue) IsEmpty() bool {
	if this.front == -1 && this.rear == -1 {
		return true
	}
	return false
}

/** Checks whether the circular queue is full or not. */
func (this *MyCircularQueue) IsFull() bool {
	if this.front == (this.rear+1)%this.size {
		return true
	}
	return false
}
