package main

import "sort"

func minCost(colors string, neededTime []int) int {
	res := 0
	r := 0
	for i := 1; i < len(colors); i++ {
		if colors[i-1] == colors[i] {
			r, i = findSame(i-1, colors, neededTime)
			res += r
			continue
		}

	}
	return res
}

func findSame(idx int, s string, neededTime []int) (rs int, ix int) {
	i := idx
	res := 0
	for i < len(s)-1 {
		if s[i+1] != s[i] {
			break
		}
		i++
	}

	same := neededTime[idx : i+1]
	sort.Ints(same)

	for i := 0; i < len(same)-1; i++ {
		res += same[i]
	}

	return res, i + 1
}
