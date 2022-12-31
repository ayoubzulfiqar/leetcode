package main

func uniquePathsIII(grid [][]int) int {
	x, y := findStart(grid)
	return helper(grid, x, y)
}

func helper(grid [][]int, x, y int) int {
	if grid[x][y] == 2 {
		if noZeroes(grid) {
			return 1
		}
		return 0
	}

	grid[x][y] = 3
	ans := 0

	if x-1 >= 0 && (grid[x-1][y] == 0 || grid[x-1][y] == 2) {
		ans += helper(grid, x-1, y)
	}
	if y-1 >= 0 && (grid[x][y-1] == 0 || grid[x][y-1] == 2) {
		ans += helper(grid, x, y-1)
	}
	if x+1 < len(grid) && (grid[x+1][y] == 0 || grid[x+1][y] == 2) {
		ans += helper(grid, x+1, y)
	}
	if y+1 < len(grid[0]) && (grid[x][y+1] == 0 || grid[x][y+1] == 2) {
		ans += helper(grid, x, y+1)
	}

	grid[x][y] = 0

	return ans
}

func noZeroes(grid [][]int) bool {
	for _, x := range grid {
		for _, v := range x {
			if v == 0 {
				return false
			}
		}
	}

	return true
}

func findStart(grid [][]int) (int, int) {
	for x := 0; x < len(grid); x++ {
		for y := 0; y < len(grid[0]); y++ {
			if grid[x][y] == 1 {
				return x, y
			}
		}
	}

	return -1, -1 //error
}
