package main

import "sort"

func findLongestChain(pairs [][]int) int {
	sort.Slice(pairs, func(i, j int) bool {
		return pairs[i][1] < pairs[j][1]
	})

	count := 1
	pairEnd := pairs[0][1]

	for i := 1; i < len(pairs); i++ {
		if pairs[i][0] > pairEnd {
			count++
			pairEnd = pairs[i][1]
		}
	}

	return count
}
