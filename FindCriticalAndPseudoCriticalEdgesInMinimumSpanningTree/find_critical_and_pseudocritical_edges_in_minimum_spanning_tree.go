package main

import "sort"

type DisjointSet struct {
	parent []int
}

func NewDisjointSet(n int) *DisjointSet {
	parent := make([]int, n)
	for i := 0; i < n; i++ {
		parent[i] = i
	}
	return &DisjointSet{parent: parent}
}

func (ds *DisjointSet) find(i int) int {
	if i == ds.parent[i] {
		return i
	}
	ds.parent[i] = ds.find(ds.parent[i])
	return ds.parent[i]
}

func (ds *DisjointSet) union(u, v int) bool {
	pu, pv := ds.find(u), ds.find(v)
	if pu == pv {
		return false
	}
	ds.parent[pu] = pv
	return true
}

func findCriticalAndPseudoCriticalEdges(n int, edges [][]int) [][]int {
	graph := make([][][]int, n)
	for i := 0; i < n; i++ {
		graph[i] = make([][]int, n)
		for j := 0; j < n; j++ {
			graph[i][j] = make([]int, 2)
		}
	}

	for i := 0; i < len(edges); i++ {
		edge := edges[i]
		from, to, weight := edge[0], edge[1], edge[2]
		graph[from][to][0] = weight
		graph[to][from][0] = weight
		graph[from][to][1] = i
		graph[to][from][1] = i
	}

	minimumSpanningTree := make([][]int, n)
	for i := 0; i < n; i++ {
		minimumSpanningTree[i] = []int{}
	}

	mstEdgeSet := make([]bool, len(edges))

	sort.Slice(edges, func(i, j int) bool {
		return edges[i][2] < edges[j][2]
	})

	buildMinimumSpanningTree(n, edges, mstEdgeSet, minimumSpanningTree, graph)

	result := make([][]int, 2)
	pseudoCriticalEdges := make(map[int]struct{})
	criticalEdges := []int{}

	// Finding pseudo-critical edges
	for i := 0; i < len(edges); i++ {
		from, to, weight := edges[i][0], edges[i][1], edges[i][2]
		index := graph[from][to][1]
		if !mstEdgeSet[index] {
			currentSet := make(map[int]struct{})
			isPseudoCritical := isPath(from, to, weight, -1, minimumSpanningTree, graph, currentSet)
			if isPseudoCritical && len(currentSet) > 0 {
				pseudoCriticalEdges[index] = struct{}{}
				for idx := range currentSet {
					pseudoCriticalEdges[idx] = struct{}{}
				}
			}
		}
	}

	// Finding critical edges

	for i := 0; i < len(edges); i++ {
		from, to := edges[i][0], edges[i][1]
		index := graph[from][to][1]
		_, found := pseudoCriticalEdges[index]
		if mstEdgeSet[index] && !found {
			criticalEdges = append(criticalEdges, index)
		}
	}

	result[0] = criticalEdges
	pseudoCriticalList := []int{}
	for idx := range pseudoCriticalEdges {
		pseudoCriticalList = append(pseudoCriticalList, idx)
	}
	result[1] = pseudoCriticalList

	return result
}

func isPath(from, to, weight, previous int, minimumSpanningTree [][]int, graph [][][]int, indices map[int]struct{}) bool {
	if from == to {
		return true
	}
	for _, neighbor := range minimumSpanningTree[from] {
		if previous != neighbor {
			if isPath(neighbor, to, weight, from, minimumSpanningTree, graph, indices) {
				if graph[from][neighbor][0] == weight {
					indices[graph[from][neighbor][1]] = struct{}{}
				}
				return true
			}
		}
	}
	return false
}

func buildMinimumSpanningTree(n int, edges [][]int, mstEdgeSet []bool, minimumSpanningTree [][]int, graph [][][]int) {
	weight := 0
	ds := NewDisjointSet(n)

	for i := 0; i < len(edges); i++ {
		if ds.union(edges[i][0], edges[i][1]) {
			weight += edges[i][2]
			edge := edges[i]
			minimumSpanningTree[edge[0]] = append(minimumSpanningTree[edge[0]], edge[1])
			minimumSpanningTree[edge[1]] = append(minimumSpanningTree[edge[1]], edge[0])
			mstEdgeSet[graph[edge[0]][edge[1]][1]] = true
		}
	}
}
