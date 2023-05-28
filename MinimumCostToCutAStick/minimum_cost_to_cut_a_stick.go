package main

import (
	"fmt"
	"math"
)

type Solution struct {
	set  []int
	n    int
	memo map[int]int
}

func minCost(n int, cuts []int) int {
	s := Solution{}
	s.set = make([]int, len(cuts))
	copy(s.set, cuts)
	s.n = n
	s.memo = make(map[int]int)

	return s.helper(0, n)
}

func (s *Solution) helper(i, j int) int {
	key := i*(s.n+1) + j
	if val, ok := s.memo[key]; ok {
		return val
	}

	res := math.MaxInt32
	for _, c := range s.set {
		if c > i && c < j {
			res = min(res, (j-i)+s.helper(i, c)+s.helper(c, j))
		}
	}

	if res == math.MaxInt32 {
		res = 0
	}
	s.memo[key] = res

	return res
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func main() {
	n := 9
	cuts := []int{5, 6, 1, 4, 2}
	fmt.Println(minCost(n, cuts))
}
