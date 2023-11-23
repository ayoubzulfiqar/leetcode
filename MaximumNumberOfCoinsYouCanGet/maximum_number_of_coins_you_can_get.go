package main

import "sort"

func maxCoins(piles []int) int {
	sort.Ints(piles)
	var n int = len(piles)
	var kt int = n / 3
	var i int = n - 2
	var ans int = 0

	for kt > 0 {
		kt--
		ans += piles[i]
		i = i - 2
	}
	return ans
}
