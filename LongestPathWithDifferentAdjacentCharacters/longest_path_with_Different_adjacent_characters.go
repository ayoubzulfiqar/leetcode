package main

import "sort"

func longestPath(parent []int, s string) (max int) {
	gr := make([][]int, len(parent))
	for ch := 1; ch < len(parent); ch++ {
		gr[parent[ch]] = append(gr[parent[ch]], ch)
	}
	dfs(0, gr, []byte(s), &max)
	return
}

func dfs(cur int, gr [][]int, s []byte, max *int) int {
	maxpq := []int{}
	for _, ch := range gr[cur] {
		l := dfs(ch, gr, s, max)
		if s[cur] != s[ch] {
			maxpq = append(maxpq, l)
		}
	}
	sort.Ints(maxpq)
	locmax, retmax := 1, 1
	if len(maxpq) > 0 {
		locmax += maxpq[len(maxpq)-1]
		retmax += maxpq[len(maxpq)-1]
	}
	if len(maxpq) > 1 {
		locmax += maxpq[len(maxpq)-2]
	}

	if *max < locmax {
		*max = locmax
	}

	return retmax
}
