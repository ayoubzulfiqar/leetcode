package main

func minTime(n int, edges [][]int, hasApple []bool) int {
	graph := make([][]int, n)
	for _, edge := range edges {
		graph[edge[0]] = append(graph[edge[0]], edge[1])
		graph[edge[1]] = append(graph[edge[1]], edge[0])
	}

	out := 0
	visited := make([]bool, n)
	visited[0] = true
	for _, node := range graph[0] {
		out += traverse(graph, node, hasApple, visited)
	}
	return out
}

func traverse(graph [][]int, node int, hasApple []bool, visited []bool) int {
	out := 0
	visited[node] = true
	for _, n := range graph[node] {
		if !visited[n] {
			out += traverse(graph, n, hasApple, visited)
		}
	}
	if hasApple[node] || out != 0 {
		out += 2
	}
	return out
}
