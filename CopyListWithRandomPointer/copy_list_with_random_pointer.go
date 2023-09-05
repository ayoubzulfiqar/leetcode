package main

type Node struct {
	Val    int
	Next   *Node
	Random *Node
}

func insertAtTail(head **Node, tail **Node, data int) {
	temp := &Node{Val: data}
	if *head == nil {
		*head = temp
		*tail = temp
		return
	}
	(*tail).Next = temp
	*tail = temp
}

func copyRandomList(head *Node) *Node {
	if head == nil {
		return nil
	}

	// Step 1: Create a clone linked list
	temp := head
	var cloneHead *Node
	var cloneTail *Node
	for temp != nil {
		insertAtTail(&cloneHead, &cloneTail, temp.Val)
		temp = temp.Next
	}

	// Step 2: Connect links between clone and original list
	cloneNode := cloneHead
	originalNode := head
	for originalNode != nil && cloneNode != nil {
		originalNext := originalNode.Next
		originalNode.Next = cloneNode
		originalNode = originalNext

		cloneNext := cloneNode.Next
		cloneNode.Next = originalNode
		cloneNode = cloneNext
	}

	// Step 3: Connect random pointers
	temp = head
	for temp != nil {
		if temp.Random != nil {
			temp.Next.Random = temp.Random.Next
		}
		temp = temp.Next.Next
	}

	// Revert Step 2
	originalNode = head
	cloneNode = cloneHead
	for originalNode != nil && cloneNode != nil {
		originalNode.Next = cloneNode.Next
		originalNode = originalNode.Next
		if originalNode != nil {
			cloneNode.Next = originalNode.Next
		}
		cloneNode = cloneNode.Next
	}

	// Return the cloned head
	return cloneHead
}
