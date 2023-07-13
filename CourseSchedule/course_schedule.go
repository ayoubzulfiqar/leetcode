package main




func canFinish(numCourses int, prerequisites [][]int) bool {
	graph := make([][]int, numCourses)
	for i := 0; i < numCourses; i++ {
		graph[i] = make([]int, 0)
	}

	for _, pre := range prerequisites {
		x := pre[0]
		y := pre[1]
		graph[x] = append(graph[x], y)
	}

	visited := make([]int, numCourses)
	for i := 0; i < numCourses; i++ {
		if hasCycle(graph, visited, i) {
			return false // Cycle detected
		}
	}

	return true
}

func  hasCycle(graph [][]int, visited []int, node int) bool {
	if visited[node] == 1 {
		return true // Cycle detected
	}
	if visited[node] == -1 {
		return false // Already visited and no cycle
	}

	visited[node] = 1 // Mark node as visited

	for _, neighbor := range graph[node] {
		if hasCycle(graph, visited, neighbor) {
			return true // Cycle detected
		}
	}

	visited[node] = -1 // Mark node as visited and no cycle
	return false
}




