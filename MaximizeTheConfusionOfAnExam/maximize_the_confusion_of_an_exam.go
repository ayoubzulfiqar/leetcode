package main

type Node struct {
	value int
	next  *Node
}

func NewNode(value int) *Node {
	return &Node{
		value: value,
		next:  nil,
	}
}

type LinkedList struct {
	head *Node
	tail *Node
}

func NewLinkedList() *LinkedList {
	return &LinkedList{
		head: nil,
		tail: nil,
	}
}

func (list *LinkedList) Add(value int) {
	newNode := NewNode(value)
	if list.head == nil {
		list.head = newNode
		list.tail = newNode
	} else {
		list.tail.next = newNode
		list.tail = newNode
	}
}

func (list *LinkedList) RemoveFirst() int {
	if list.head == nil {
		return -1
	}
	value := list.head.value
	list.head = list.head.next
	if list.head == nil {
		list.tail = nil
	}
	return value
}

func (list *LinkedList) IsEmpty() bool {
	return list.head == nil
}

func maxConsecutiveAnswers(answerKey string, k int) int {
	return max(flipper(answerKey, k, 'F'), flipper(answerKey, k, 'T'))
}

func flipper(answerKey string, k int, countLetter rune) int {
	maximum := 0
	count := 0
	linkedList := NewLinkedList()
	for i, letter := range answerKey {
		if letter == countLetter {
			count++
		} else if k > 0 {
			linkedList.Add(i)
			k--
			count++
		} else {
			linkedList.Add(i)
			maximum = max(count, maximum)
			firstEncountered := linkedList.RemoveFirst()
			if firstEncountered != -1 {
				count = i - firstEncountered
			}
		}
	}
	maximum = max(count, maximum)
	return maximum
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}
