package main

func minimumFuelCost(roads [][]int, seats int) int64 {
	adjList := make([][]int, len(roads)+1)
	for i := range roads {
		a, b := roads[i][0], roads[i][1]
		adjList[a] = append(adjList[a], b)
		adjList[b] = append(adjList[b], a)
	}
	var fuel int64
	dfs(0, -1, adjList, seats, &fuel)
	return fuel
}

func dfs(city int, parent int, adjList [][]int, seats int, fuel *int64) int {
	numNodesInSubtree := 1
	for _, nextCity := range adjList[city] {
		if nextCity == parent {
			continue
		}
		numNodes := dfs(nextCity, city, adjList, seats, fuel)
		numNodesInSubtree += numNodes
		(*fuel) += int64(numNodes / seats)
		if numNodes%seats != 0 {
			(*fuel)++
		}
	}
	return numNodesInSubtree
}
