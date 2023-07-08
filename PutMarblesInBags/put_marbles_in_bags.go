package main

import "container/heap"

type MinHeap []int

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i] < h[j] }
func (h MinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MinHeap) Push(x interface{}) {
	*h = append(*h, x.(int))
}

func (h *MinHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[:n-1]
	return x
}

type MaxHeap []int

func (h MaxHeap) Len() int           { return len(h) }
func (h MaxHeap) Less(i, j int) bool { return h[i] > h[j] }
func (h MaxHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MaxHeap) Push(x interface{}) {
	*h = append(*h, x.(int))
}

func (h *MaxHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[:n-1]
	return x
}

func putMarbles(weights []int, k int) int64 {
	maxQ := &MaxHeap{}
	minQ := &MinHeap{}
	heap.Init(maxQ)
	heap.Init(minQ)

	n := len(weights)
	for i := 0; i < n-1; i++ {
		heap.Push(maxQ, weights[i]+weights[i+1])
		if maxQ.Len() == k {
			heap.Pop(maxQ)
		}

		heap.Push(minQ, weights[i]+weights[i+1])
		if minQ.Len() == k {
			heap.Pop(minQ)
		}
	}

	var diff int64
	for len(*minQ) > 0 {
		diff += int64(heap.Pop(minQ).(int)) - int64(heap.Pop(maxQ).(int))
	}

	return diff
}
