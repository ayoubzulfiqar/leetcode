package main

type nodeWithColor struct {
	vertex int
	color  byte
}

func shortestAlternatingPaths(n int, redEdges [][]int, blueEdges [][]int) []int {
	var adj [2][][]int
	adj[0], adj[1] = buildAdj(n, redEdges), buildAdj(n, blueEdges)

	var visit [2][]int
	visit[0], visit[1] = make([]int, n), make([]int, n)
	for i := range visit[0] {
		visit[0][i] = -1
		visit[1][i] = -1
	}
	visit[0][0], visit[1][0] = 0, 0

	queue := make([]nodeWithColor, 0, 2*n)
	queue = append(queue, nodeWithColor{vertex: 0, color: 0})
	queue = append(queue, nodeWithColor{vertex: 0, color: 1})

	for len(queue) > 0 {
		node := queue[0]
		queue = queue[1:]

		nextColor, nextDistance := 1^node.color, 1+visit[node.color][node.vertex]

		edges, visiting := adj[nextColor][node.vertex], visit[nextColor]
		for _, v := range edges {
			if visiting[v] < 0 {
				visiting[v] = nextDistance
				queue = append(queue, nodeWithColor{vertex: v, color: nextColor})
			}
		}
	}

	ans := make([]int, n)
	for i := range ans {
		if v1, v2 := visit[0][i], visit[1][i]; v1 < 0 || v2 < 0 {
			ans[i] = max(v1, v2)
		} else {
			ans[i] = min(v1, v2)
		}
	}

	return ans
}

func buildAdj(n int, edges [][]int) [][]int {
	adj := make([][]int, n)
	for _, e := range edges {
		adj[e[0]] = append(adj[e[0]], e[1])
	}
	return adj
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}
