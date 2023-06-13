package main

func transpose(grid [][]int) [][]int {
	n := len(grid)
	gc := make([][]int, n)

	for i := 0; i < n; i++ {
		v := make([]int, n)
		for j := 0; j < n; j++ {
			v[j] = grid[j][i] // column-wise pushing
		}
		gc[i] = v
	}

	return gc
}

func isListEqual(firstList []int, secondList []int) bool {
	if len(firstList) != len(secondList) {
		return false
	}

	for i := 0; i < len(firstList); i++ {
		if firstList[i] != secondList[i] {
			return false
		}
	}

	return true
}

func equalPairs(grid [][]int) int {
	gc := transpose(grid)
	n := len(grid)

	ans := 0
	for i := 0; i < n; i++ {
		for j := 0; j < n; j++ {
			if isListEqual(grid[i], gc[j]) {
				ans++
			}
		}
	}

	return ans
}
