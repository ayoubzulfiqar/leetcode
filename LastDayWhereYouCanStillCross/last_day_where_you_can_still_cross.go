package main

/*---------------- BFS

func isPossible(m int, n int, t int, cells [][]int) bool {
	grid := make([][]int, m+1)
	for i := range grid {
		grid[i] = make([]int, n+1)
	}

	directions := [][]int{{1, 0}, {-1, 0}, {0, 1}, {0, -1}}

	for i := 0; i < t; i++ {
		grid[cells[i][0]][cells[i][1]] = 1
	}

	queue := [][]int{}

	for i := 1; i <= n; i++ {
		if grid[1][i] == 0 {
			queue = append(queue, []int{1, i})
			grid[1][i] = 1
		}
	}

	for len(queue) > 0 {
		cell := queue[0]
		queue = queue[1:]
		r, c := cell[0], cell[1]

		for _, dir := range directions {
			nr, nc := r+dir[0], c+dir[1]

			if nr > 0 && nc > 0 && nr <= m && nc <= n && grid[nr][nc] == 0 {
				grid[nr][nc] = 1

				if nr == m {
					return true
				}

				queue = append(queue, []int{nr, nc})
			}
		}
	}

	return false
}

func latestDayToCross(row int, col int, cells [][]int) int {
	left, right := 0, row*col
	latestPossibleDay := 0

	for left < right-1 {
		mid := left + (right-left)/2

		if isPossible(row, col, mid, cells) {
			left = mid
			latestPossibleDay = mid
		} else {
			right = mid
		}
	}

	return latestPossibleDay
}
*/

/*---------------DFS
var (
	n, m int
	d    = []int{0, 1, 0, -1, 0}
)

func dfs(vis [][]int, v [][]int, i int, j int) bool {
	vis[i][j] = 1
	stack := [][]int{{i, j}}
	ans := false

	for len(stack) > 0 {
		cell := stack[len(stack)-1]
		stack = stack[:len(stack)-1]
		r, c := cell[0], cell[1]

		if r == n-1 {
			ans = true
			break
		}

		for k := 0; k < 4; k++ {
			nr := r + d[k]
			nc := c + d[k+1]
			if nr >= 0 && nc >= 0 && nr < n && nc < m && vis[nr][nc] == 0 && v[nr][nc] == 0 {
				vis[nr][nc] = 1
				stack = append(stack, []int{nr, nc})
			}
		}
	}

	return ans
}

func latestDayToCross(row int, col int, cells [][]int) int {
	l, r := 0, len(cells)-1
	n = row
	m = col
	day := 0

	for l <= r {
		mid := (l + r) / 2
		v := make([][]int, row)
		for i := range v {
			v[i] = make([]int, col)
		}

		for i := 0; i <= mid; i++ {
			v[cells[i][0]-1][cells[i][1]-1] = 1
		}

		vis := make([][]int, row)
		for i := range vis {
			vis[i] = make([]int, col)
		}

		ans := false

		for i := 0; i < col; i++ {
			if vis[0][i] == 0 && v[0][i] == 0 {
				ans = ans || dfs(vis, v, 0, i)
			}
		}

		if ans {
			day = mid
			l = mid + 1
		} else {
			r = mid - 1
		}
	}

	return day + 1
}

*/

var (
	p   []int // Union-Find data structure
	dir = [][]int{{-1, 0}, {1, 0}, {0, 1}, {0, -1}}
)

func find(x int) int {
	if p[x] < 0 {
		return x
	}
	p[x] = find(p[x])
	return p[x]
}

func uni(x, y int) {
	x = find(x)
	y = find(y)
	if x == y {
		return
	}
	p[y] = x
}

func latestDayToCross(row, col int, cells [][]int) int {
	grid := make([][]int, row)
	for i := range grid {
		grid[i] = make([]int, col)
		for j := range grid[i] {
			grid[i][j] = 1
		}
	}

	p = make([]int, row*col+3)
	for i := range p {
		p[i] = -1
	}

	startG := row*col + 1
	endG := row*col + 2

	for j := 0; j < col; j++ {
		uni(j, startG)
		uni((row-1)*col+j, endG)
	}

	for i := row*col - 1; i >= 0; i-- {
		r := cells[i][0] - 1
		c := cells[i][1] - 1
		grid[r][c] = 0
		key := r*col + c

		for k := 0; k < 4; k++ {
			nr := r + dir[k][0]
			nc := c + dir[k][1]

			if nr >= 0 && nr < row && nc >= 0 && nc < col && grid[nr][nc] == 0 {
				nKey := nr*col + nc
				uni(key, nKey)
			}

			if find(startG) == find(endG) {
				return i
			}
		}
	}

	return row*col - 1
}
