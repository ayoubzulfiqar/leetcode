package main

/*

--NOT FAST

func maxSlidingWindow(arr []int, k int) []int {
	n := len(arr)
	LOG := make([]int, 100005)
	sp := make([][]int, n)

	LOG[1] = 0
	for i := 2; i <= n; i++ {
		LOG[i] = LOG[i/2] + 1
	}

	for i := 0; i < n; i++ {
		sp[i] = make([]int, 20)
		sp[i][0] = arr[i]
	}

	preProcess(sp, LOG, n)

	var ans []int
	for i := 0; i <= n-k; i++ {
		a, b := i, i+k-1
		mx := query(sp, LOG, a, b)
		ans = append(ans, mx)
	}

	return ans
}

func query(sp [][]int, LOG []int, a, b int) int {
	length := b - a + 1
	j := LOG[length]
	ans := int(math.Max(float64(sp[a][j]), float64(sp[b-(1<<j)+1][j])))
	return ans
}

func preProcess(sp [][]int, LOG []int, n int) {
	for j := 1; j < 18; j++ {
		for i := 0; i+(1<<j)-1 < n; i++ {
			sp[i][j] = int(math.Max(float64(sp[i][j-1]), float64(sp[i+(1<<(j-1))][j-1])))
		}
	}
}

*/

import "container/heap"
	


type Pair struct {
	index, value int
}

type PairHeap []Pair

func (h PairHeap) Len() int           { return len(h) }
func (h PairHeap) Less(i, j int) bool { return h[i].value > h[j].value || (h[i].value == h[j].value && h[i].index < h[j].index) }
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

func maxSlidingWindow(nums []int, k int) []int {
	res := make([]int, len(nums)-k+1)

	i, j, index := 0, 0, 0
	pq := &PairHeap{}
	heap.Init(pq)

	for j < len(nums) {
		pair := Pair{j, nums[j]}
		heap.Push(pq, pair)
		if j-i+1 < k {
			j++
		} else if j-i+1 == k {
			for (*pq)[0].index < i {
				heap.Pop(pq)
			}
			first := (*pq)[0]
			res[index] = first.value
			if first.index < i+1 {
				heap.Pop(pq)
			}
			i++
			j++
			index++
		}
	}

	return res
}


