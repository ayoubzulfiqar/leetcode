package main

import "math"

func validPath(n int, edges [][]int, start int, end int) bool {
	way := make([]int, n)
	for i := range way {
		way[i] = i
	}
	root := func(n int, way []int) int {
		for way[n] != n {
			n = way[n]
		}
		return n
	}
	for _, e := range edges {
		root0, root1 := root(e[0], way), root(e[1], way)
		minValue := min(root0, root1)
		way[e[0]] = minValue
		way[e[1]] = minValue
		way[root0] = minValue
		way[root1] = minValue
	}
	return root(start, way) == root(end, way)
}

func min(values ...int) int {
	minValue := math.MaxInt64
	for _, v := range values {
		if v < minValue {
			minValue = v
		}
	}
	return minValue
}
