package main

func min(a int, b int) int {
	if a < b {
		return a
	}
	return b
}

func max(a int, b int) int {
	if a > b {
		return a
	}
	return b
}

func maxDistance(grid [][]int) int {
	var m int = len(grid)
	var n int = len(grid[0])
	var x int = n + m
	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			if grid[i][j] == 1 {
				continue
			}
			var top int = x
			var left int = x
			if i-1 >= 0 {
				top = grid[i-1][j]
			}
			if j-1 >= 0 {
				left = grid[i][j-1]
			}
			grid[i][j] = min(top, left) + 1
		}
	}
	for i := m - 1; i >= 0; i-- {
		for j := n - 1; j >= 0; j-- {
			if grid[i][j] == 1 {
				continue
			}
			var bottom int = x
			var right int = x
			if i+1 < m {
				bottom = grid[i+1][j]
			}
			if j+1 < n {
				right = grid[i][j+1]
			}
			grid[i][j] = min(grid[i][j], min(bottom, right)+1)
		}
	}
	var count int = 0
	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			count = max(count, grid[i][j])
		}

	}
	if count-1 == n+m+1 || count-1 == 0 {
		return -1
	}
	return count - 1
}
