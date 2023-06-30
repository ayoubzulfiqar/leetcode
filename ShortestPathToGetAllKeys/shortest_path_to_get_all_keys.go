// package main

// func shortestPathAllKeys(grid []string) int {
// 	m := len(grid)
// 	n := len(grid[0])

// 	keyBit := make(map[byte]int)
// 	bitStart := 0

// 	for i := 0; i < m; i++ {
// 		for j := 0; j < n; j++ {
// 			if isLowerCase(grid[i][j]) {
// 				keyBit[grid[i][j]] = bitStart
// 				bitStart++
// 			}
// 		}
// 	}

// 	maskEnd := (1 << bitStart) - 1
// 	maskSize := 1 << bitStart

// 	memo := make([][][]bool, m)
// 	for i := range memo {
// 		memo[i] = make([][]bool, n)
// 		for j := range memo[i] {
// 			memo[i][j] = make([]bool, maskSize)
// 		}
// 	}

// 	var start []int

// 	for i := 0; i < m; i++ {
// 		for j := 0; j < n; j++ {
// 			if grid[i][j] == '@' {
// 				start = []int{i, j, 0}
// 			}
// 		}
// 	}

// 	queue := [][]int{start}
// 	step := 0

// 	for len(queue) > 0 {
// 		sz := len(queue)

// 		for k := 0; k < sz; k++ {
// 			current := queue[0]
// 			queue = queue[1:]
// 			row := current[0]
// 			col := current[1]
// 			mask := current[2]

// 			if row < 0 || row >= m || col < 0 || col >= n {
// 				continue
// 			}

// 			if grid[row][col] == '#' {
// 				continue
// 			}

// 			if isUpperCase(grid[row][col]) {
// 				lowerKey := toLowerCase(grid[row][col])
// 				if (mask & (1 << keyBit[lowerKey])) == 0 {
// 					continue
// 				}
// 			}

// 			if isLowerCase(grid[row][col]) {
// 				mask |= 1 << keyBit[grid[row][col]]
// 			}

// 			if mask == maskEnd {
// 				return step
// 			}

// 			if memo[row][col][mask] {
// 				continue
// 			}

// 			memo[row][col][mask] = true

// 			queue = append(queue, []int{row + 1, col, mask})
// 			queue = append(queue, []int{row - 1, col, mask})
// 			queue = append(queue, []int{row, col + 1, mask})
// 			queue = append(queue, []int{row, col - 1, mask})
// 		}

// 		step++
// 	}

// 	return -1
// }

// func isLowerCase(ch byte) bool {
// 	return ch >= 'a' && ch <= 'z'
// }

// func isUpperCase(ch byte) bool {
// 	return ch >= 'A' && ch <= 'Z'
// }

// func toLowerCase(ch byte) byte {
// 	return ch + 32
// }

//-------------------------------------------------------------

package main

type State struct {
	x, y, steps, keys int
}

var (
	directions = [][]int{{0, -1}, {0, 1}, {1, 0}, {-1, 0}}
)

func shortestPathAllKeys(grid []string) int {

	queue := []State{}
	n := len(grid)
	m := len(grid[0])

	start := []int{0, 0}
	keys := make(map[byte]bool)
	locks := make(map[byte]bool)
	allKeys := 0

	for i := 0; i < n; i++ {
		for j := 0; j < m; j++ {
			switch grid[i][j] {
			case '@':
				start = []int{i, j}
			case 'a', 'b', 'c', 'd', 'e', 'f':
				keys[grid[i][j]] = true
				allKeys += 1 << (grid[i][j] - 'a')
			case 'A', 'B', 'C', 'D', 'E', 'F':
				locks[grid[i][j]] = true
			}
		}
	}

	queue = append(queue, State{start[0], start[1], 0, 0})

	return traverse(grid, queue, allKeys, keys, locks)
}

func traverse(grid []string, queue []State, allKeys int, keys map[byte]bool, locks map[byte]bool) int {
	n := len(grid)
	m := len(grid[0])
	visited := make([][][]int, n)

	for i := 0; i < n; i++ {
		visited[i] = make([][]int, m)
		for j := 0; j < m; j++ {
			visited[i][j] = make([]int, allKeys+1)
			for k := 0; k <= allKeys; k++ {
				visited[i][j][k] = -1
			}
		}
	}

	for len(queue) > 0 {
		node := queue[0]
		queue = queue[1:]
		visited[node.x][node.y][node.keys] = node.steps

		for _, dir := range directions {
			newX := node.x + dir[0]
			newY := node.y + dir[1]
			if newX >= 0 && newX < n && newY >= 0 && newY < m && grid[newX][newY] != '#' {
				step := State{newX, newY, node.steps + 1, node.keys}

				s := grid[newX][newY]
				if keys[s] {
					decoded := 1 << (s - 'a')
					step.keys |= decoded
				} else if locks[s] {
					decoded := 1 << (s - 'A')
					if (step.keys & decoded) == 0 {
						continue
					}
				}

				if step.keys == allKeys {
					return step.steps
				}

				if visited[newX][newY][step.keys] == -1 {
					visited[newX][newY][step.keys] = step.steps
					queue = append(queue, step)
				}
			}
		}
	}
	return -1
}
