package main

import (
	"container/heap"
	"sort"
)

type Edge struct {
	pos    int
	height int
}

type PriorityQueue []*Edge

func (pq PriorityQueue) Len() int           { return len(pq) }
func (pq PriorityQueue) Less(i, j int) bool { return pq[i].height > pq[j].height }
func (pq PriorityQueue) Swap(i, j int)      { pq[i], pq[j] = pq[j], pq[i] }

func (pq *PriorityQueue) Push(x interface{}) {
	edge := x.(*Edge)
	*pq = append(*pq, edge)
}

func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	edge := old[n-1]
	old[n-1] = nil
	*pq = old[0 : n-1]
	return edge
}

func getSkyline(buildings [][]int) [][]int {
	n := len(buildings)
	answer := [][]int{}
	positions := make([][]int, 0, n*2)
	for i, building := range buildings {
		positions = append(positions, []int{building[0], i})
		positions = append(positions, []int{building[1], i})
	}

	sort.Slice(positions, func(i, j int) bool {
		return positions[i][0] < positions[j][0]
	})

	index := 0
	pq := make(PriorityQueue, 0, 2*n)
	heap.Init(&pq)
	for index < len(positions) {
		curPos := positions[index][0]

		for index < len(positions) && positions[index][0] == curPos {
			b := positions[index][1]
			if curPos == buildings[b][0] {
				heap.Push(&pq, &Edge{buildings[b][1], buildings[b][2]})
			}
			index++
		}

		for len(pq) > 0 && pq[0].pos <= curPos {
			heap.Pop(&pq)
		}

		maxHeight := 0
		if len(pq) > 0 {
			maxHeight = pq[0].height
		}

		if len(answer) == 0 || answer[len(answer)-1][1] != maxHeight {
			answer = append(answer, []int{curPos, maxHeight})
		}
	}
	return answer
}

/*
func getSkyline(buildings [][]int) [][]int {
    n := len(buildings)
    answer := [][]int{}
    uniqPositions := make(map[int]struct{}, n*2)
    for _, building := range buildings {
        uniqPositions[building[0]] = struct{}{}
        uniqPositions[building[1]] = struct{}{}
    }

    sortedUniqPositions := make([]int, 0, len(uniqPositions))
    for k, _ := range uniqPositions {
        sortedUniqPositions = append(sortedUniqPositions, k)
    }

    sort.Ints(sortedUniqPositions)

    for _, pos := range sortedUniqPositions {
        maxHeight := 0
        for _, building := range buildings {
            if building[0] <= pos && pos < building[1] {
                maxHeight = max(maxHeight, building[2])
            }
        }

        if len(answer) == 0 || answer[len(answer)-1][1] != maxHeight {
            answer = append(answer, []int{pos, maxHeight})
        }
    }
    return answer
}

func max(x, y int) int {
    if x > y {
        return x
    }
    return y
}

*/
