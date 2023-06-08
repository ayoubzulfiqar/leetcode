package main

import "sort"

func countNegatives1(grid [][]int) int {
	var count int = 0
	var rows int = len(grid)
	var columns int = len(grid[0])
	var row int = rows - 1
	var column int = 0
	for column < columns && row >= 0 {
		if grid[row][column] < 0 {
			count += columns - column
			row--
		} else {
			column++
		}
	}
	return count
}

func countNegatives(grid [][]int) int {
	var gridRowsLength int = len(grid)
	var count int = 0

	for i := 0; i < gridRowsLength; i++ {
		sort.Sort(sort.Reverse(sort.IntSlice(grid[i])))
		upperBound := sort.Search(len(grid[i]), func(j int) bool {
			return grid[i][j] < 0
		})
		count += len(grid[i]) - upperBound
	}

	return count
}
