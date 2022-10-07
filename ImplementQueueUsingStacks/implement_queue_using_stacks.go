package main

type MyQueue struct {
	stack1 Stack
	stack2 Stack
}

func Constructor() MyQueue {
	return *new(MyQueue)
}

func (this *MyQueue) Push(x int) {

	for !this.stack1.IsEmpty() {
		pop, _ := this.stack1.Pop()
		this.stack2.Push(pop)
	}

	this.stack1.Push(x)

	for !this.stack2.IsEmpty() {
		pop, _ := this.stack2.Pop()
		this.stack1.Push(pop)
	}
}

func (this *MyQueue) Pop() int {
	pop, _ := this.stack1.Pop()
	return pop
}

func (this *MyQueue) Peek() int {
	peek, _ := this.stack1.Peek()
	return peek
}

func (this *MyQueue) Empty() bool {
	return this.stack1.IsEmpty()
}

type Stack []int

func (s *Stack) IsEmpty() bool {
	return len(*s) == 0
}
func (s *Stack) Push(num int) {
	*s = append(*s, num)
}
func (s *Stack) Len() int {
	return len(*s)
}
func (s *Stack) Pop() (int, bool) {
	if s.IsEmpty() {
		return 0, false
	} else {
		index := len(*s) - 1
		elem := (*s)[index]
		*s = (*s)[:index]
		return elem, true
	}
}

func (s *Stack) Peek() (int, bool) {
	if s.IsEmpty() {
		return 0, false
	} else {
		index := len(*s) - 1
		elem := (*s)[index]
		return elem, true
	}
}
