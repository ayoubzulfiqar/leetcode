package main

func search(v []int, target int) int {
	index := lowerBound(v, target)
	return index
}

func searchMatrix(matrix [][]int, target int) bool {
	n := len(matrix)
	m := len(matrix[0])

	if n == 1 {
		j := search(matrix[0], target)
		if j == m {
			return false
		}
		return matrix[0][j] == target
	}

	col0 := make([]int, n)
	for i := 0; i < n; i++ {
		col0[i] = matrix[i][0]
	}

	i0 := search(col0, target)

	if i0 == n {
		j := search(matrix[i0-1], target)
		if j == m {
			return false
		}
		return matrix[i0-1][j] == target
	} else if col0[i0] == target {
		return true
	} else if i0 == 0 {
		return false
	} else {
		j := search(matrix[i0-1], target)
		if j == m {
			return false
		}
		return matrix[i0-1][j] == target
	}
}

func lowerBound(array []int, target int) int {
	left := 0
	right := len(array)
	for left < right {
		mid := left + (right-left)/2
		if array[mid] < target {
			left = mid + 1
		} else {
			right = mid
		}
	}
	return left
}
