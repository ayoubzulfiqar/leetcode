package main

import (
	"container/heap"
	"math"
)

type Pair struct {
	node     int
	distance int
}

type PairHeap []Pair

func (h PairHeap) Len() int           { return len(h) }
func (h PairHeap) Less(i, j int) bool { return h[i].distance < h[j].distance }
func (h PairHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *PairHeap) Push(x interface{}) {
	*h = append(*h, x.(Pair))
}

func (h *PairHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func minCostConnectPoints(points [][]int) int {
	n := len(points)
	adjList := make([][]Pair, n)

	for i := 0; i < n; i++ {
		adjList[i] = make([]Pair, 0)
	}

	for i := 0; i < n; i++ {
		for j := i; j < n; j++ {
			first := points[i]
			second := points[j]
			weight := int(math.Abs(float64(first[0]-second[0])) + math.Abs(float64(first[1]-second[1])))
			adjList[i] = append(adjList[i], Pair{j, weight})
			adjList[j] = append(adjList[j], Pair{i, weight})
		}
	}

	visited := make([]bool, n)
	pq := make(PairHeap, 0)
	heap.Init(&pq)
	pq = append(pq, Pair{0, 0})

	sum := 0

	for len(pq) > 0 {
		pair := heap.Pop(&pq).(Pair)
		node := pair.node
		dist := pair.distance

		if visited[node] {
			continue
		}

		visited[node] = true
		sum += dist

		for _, adj := range adjList[node] {
			adjNode := adj.node
			adjDistance := adj.distance

			if !visited[adjNode] {
				heap.Push(&pq, Pair{adjNode, adjDistance})
			}
		}
	}

	return sum
}
