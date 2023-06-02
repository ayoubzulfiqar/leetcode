package main

import (
	"fmt"
	"math"
)

func maximumDetonation(bombs [][]int) int {
	n := len(bombs)
	maxBombs := 0
	graph := make(map[int][]int)

	for i := 0; i < n; i++ {
		for j := 0; j < n; j++ {
			if i == j {
				continue
			}
			if math.Pow(float64(bombs[i][2]), 2) >= math.Pow(float64(bombs[i][0]-bombs[j][0]), 2)+math.Pow(float64(bombs[i][1]-bombs[j][1]), 2) {
				neighbors := graph[i]
				neighbors = append(neighbors, j)
				graph[i] = neighbors
			}
		}
	}

	for i := 0; i < n; i++ {
		visited := make(map[int]bool)
		visited[i] = true
		dfs(i, visited, graph)
		maxBombs = int(math.Max(float64(maxBombs), float64(len(visited))))
	}

	return maxBombs
}

func dfs(node int, visited map[int]bool, graph map[int][]int) {
	neighbors := graph[node]
	for _, child := range neighbors {
		if !visited[child] {
			visited[child] = true
			dfs(child, visited, graph)
		}
	}
}


