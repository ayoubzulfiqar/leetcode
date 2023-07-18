package main
/*
import (
	"container/list"
)

// LRUCache represents the LRUCache data structure
type LRUCache struct {
	k      int
	mp     map[int]*list.Element
	values *list.List
}

// Pair represents a key-value pair in the LRUCache
type Pair struct {
	key   int
	value int
}

// Constructor creates a new LRUCache with the specified capacity
func Constructor(capacity int) LRUCache {
	return LRUCache{
		k:      capacity,
		mp:     make(map[int]*list.Element),
		values: list.New(),
	}
}

// Get retrieves the value from the LRUCache given a key
func (lru *LRUCache) Get(key int) int {
	if elem, found := lru.mp[key]; found {
		lru.values.MoveToFront(elem)
		return elem.Value.(*Pair).value
	}
	return -1
}

// Put adds a key-value pair to the LRUCache
func (lru *LRUCache) Put(key int, value int) {
	if elem, found := lru.mp[key]; found {
		elem.Value.(*Pair).value = value
		lru.values.MoveToFront(elem)
	} else {
		if len(lru.mp) >= lru.k {
			// Evict the least recently used element from the cache
			last := lru.values.Back()
			delete(lru.mp, last.Value.(*Pair).key)
			lru.values.Remove(last)
		}
		newPair := &Pair{key, value}
		newElem := lru.values.PushFront(newPair)
		lru.mp[key] = newElem
	}
}
*/



type Node struct {
	key  int
	val  int
	prev *Node
	next *Node
}

func NewNode(key, val int) *Node {
	return &Node{
		key: key,
		val: val,
	}
}

type LRUCache struct {
	cap int
	mp  map[int]*Node
	head *Node
	tail *Node
}

func Constructor(capacity int) LRUCache {
	lru := LRUCache{
		cap: capacity,
		mp:  make(map[int]*Node),
		head: NewNode(-1, -1),
		tail: NewNode(-1, -1),
	}
	lru.head.next = lru.tail
	lru.tail.prev = lru.head
	return lru
}

func (lru *LRUCache) addNode(newNode *Node) {
	temp := lru.head.next
	newNode.next = temp
	newNode.prev = lru.head
	lru.head.next = newNode
	temp.prev = newNode
}

func (lru *LRUCache) deleteNode(delNode *Node) {
	delPrev := delNode.prev
	delNext := delNode.next
	delPrev.next = delNext
	delNext.prev = delPrev
}

func (lru *LRUCache) Get(key int) int {
	if node, found := lru.mp[key]; found {
		res := node.val
		lru.deleteNode(node)
		lru.addNode(node)
		lru.mp[key] = lru.head.next
		return res
	}
	return -1
}

func (lru *LRUCache) Put(key, value int) {
	if node, found := lru.mp[key]; found {
		delete(lru.mp, key)
		lru.deleteNode(node)
	}
	if len(lru.mp) == lru.cap {
		delete(lru.mp, lru.tail.prev.key)
		lru.deleteNode(lru.tail.prev)
	}
	lru.addNode(NewNode(key, value))
	lru.mp[key] = lru.head.next
}

