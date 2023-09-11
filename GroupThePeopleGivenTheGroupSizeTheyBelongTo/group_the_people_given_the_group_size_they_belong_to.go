package main



type NodeList struct {
	Val  int
	Next *NodeList
}

type LinkedList struct {
	Head   *NodeList
	Length int // Add a Length field to keep track of the list length
}

func NewLinkedList() *LinkedList {
	return &LinkedList{nil, 0}
}

func (ll *LinkedList) Add(val int) {
	newNode := &NodeList{Val: val, Next: nil}
	if ll.Head == nil {
		ll.Head = newNode
	} else {
		current := ll.Head
		for current.Next != nil {
			current = current.Next
		}
		current.Next = newNode
	}
	ll.Length++ // Increase the length when adding a node
}

func groupThePeople(groupSizes []int) [][]int {
	groupMap := make(map[int]*LinkedList)
	result := make([][]int, 0)

	for person, groupSize := range groupSizes {
		if _, exists := groupMap[groupSize]; !exists {
			groupMap[groupSize] = NewLinkedList()
		}
		groupMap[groupSize].Add(person)

		if groupMap[groupSize].Length == groupSize {
			group := make([]int, groupSize)
			current := groupMap[groupSize].Head
			for i := 0; i < groupSize; i++ {
				group[i] = current.Val
				current = current.Next
			}
			result = append(result, group)
			delete(groupMap, groupSize)
		}
	}

	return result
}


