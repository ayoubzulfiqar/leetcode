package main

func countSubTrees(n int, edges [][]int, labels string) []int {
	var graph = make([][]int, n)
	for row := range graph {
		graph[row] = make([]int, 0)
	}

	for _, edge := range edges {
		graph[edge[0]] = append(graph[edge[0]], edge[1])
		graph[edge[1]] = append(graph[edge[1]], edge[0])
	}

	var visited = make([]bool, n)
	var ans = make([]int, n)
	dfs(0, graph, visited, &ans, labels)
	return ans
}

func dfs(currentNode int, graph [][]int, visited []bool, ans *[]int, labels string) []int {
	var cnt = make([]int, 26)
	if visited[currentNode] {
		return cnt
	}

	visited[currentNode] = true
	var currentChar byte = labels[currentNode]

	for i := 0; i < len(graph[currentNode]); i++ {
		sub := dfs(graph[currentNode][i], graph, visited, ans, labels)
		for j := 0; j < 26; j++ {
			cnt[j] += sub[j]
		}
	}

	cnt[currentChar-'a']++
	(*ans)[currentNode] = cnt[currentChar-'a']
	return cnt
}
