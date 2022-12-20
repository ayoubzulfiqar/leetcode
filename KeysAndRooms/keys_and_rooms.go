package main

// func canVisitAllRooms(rooms [][]int) bool {
// 	if len(rooms) == 0 {
// 		return true
// 	}
// 	var visited []bool = make([]bool, len(rooms))
// 	depthFirstSearch(0, rooms, visited)
// 	for i := 0; i < len(rooms); i++ {
// 		if !visited[i] {
// 			return false
// 		}
// 	}
// 	return true
// }

// func depthFirstSearch(index int, rooms [][]int, visited []bool) {
// 	visited[index] = true
// 	for _, n := range rooms[index] {
// 		if !visited[n] {
// 			depthFirstSearch(n, rooms, visited)
// 		}
// 	}
// }

// breadth fist search
func canVisitAllRooms(rooms [][]int) bool {
	visited := make([]bool, len(rooms))
	visited[0] = true
	q := []int{0}
	locked := len(rooms) - 1

	for len(q) > 0 && locked != 0 {
		v := q[0]
		q = q[1:]

		for _, keys := range rooms[v] {
			if visited[keys] {
				continue
			}
			q = append(q, keys)
			visited[keys] = true
			locked--
		}
	}

	return locked == 0
}
