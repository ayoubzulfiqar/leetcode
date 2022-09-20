package main

import (
	"container/heap"
	"math"
	"sort"
)

func maxPerformance(n int, speed []int, efficiency []int, k int) int {
	engineers := make([][2]int, n)
	for i := 0; i < n; i++ {
		engineers[i] = [2]int{efficiency[i], speed[i]}
	}
	sort.Sort(Engineers(engineers))
	totalSpeed, res := 0, math.MinInt32
	pq := &IntHeap{}
	heap.Init(pq)
	for _, engineer := range engineers {
		heap.Push(pq, engineer[1])
		totalSpeed += engineer[1]
		if pq.Len() > k {
			totalSpeed -= heap.Pop(pq).(int)
		}
		if totalSpeed*engineer[0] > res {
			res = totalSpeed * engineer[0]
		}
	}
	return res % int(1e9+7)
}

type IntHeap []int

func (h IntHeap) Len() int           { return len(h) }
func (h IntHeap) Less(i, j int) bool { return h[i] < h[j] }
func (h IntHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *IntHeap) Push(x interface{}) {
	// Push and Pop use pointer receivers because they modify the slice's length,
	// not just its contents.
	*h = append(*h, x.(int))
}

func (h *IntHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

type Engineers [][2]int

func (e Engineers) Len() int {
	return len(e)
}

func (e Engineers) Less(i, j int) bool {
	return e[i][0] > e[j][0]
}

func (e Engineers) Swap(i, j int) {
	e[i][0], e[j][0] = e[j][0], e[i][0]
	e[i][1], e[j][1] = e[j][1], e[i][1]
}

/*
Runtime: 76 ms, faster than 100.00% of Go online submissions for Maximum Performance of a Team.
Memory Usage: 10.1 MB, less than 100.00% of Go online submissions for Maximum Performance of a Team.
*/
