package main

func updateMatrix(mat [][]int) [][]int {
	n := len(mat)
	m := len(mat[0])

	if mat[0][0] != 0 {
		mat[0][0] = m + n
	}

	// Travel top down
	for j := 1; j < m; j++ {
		if mat[0][j] != 0 {
			mat[0][j] = mat[0][j-1] + 1
		}
	}
	for i := 1; i < n; i++ {
		if mat[i][0] != 0 {
			mat[i][0] = mat[i-1][0] + 1
		}
	}
	for i := 1; i < n; i++ {
		for j := 1; j < m; j++ {
			if mat[i][j] != 0 {
				mat[i][j] = min(mat[i-1][j], mat[i][j-1]) + 1
			}
		}
	}

	// Travel up
	for j := m - 2; j >= 0; j-- {
		if mat[n-1][j] != 0 {
			mat[n-1][j] = min(mat[n-1][j], mat[n-1][j+1]+1)
		}
	}
	for i := n - 2; i >= 0; i-- {
		if mat[i][m-1] != 0 {
			mat[i][m-1] = min(mat[i][m-1], mat[i+1][m-1]+1)
		}
	}
	for i := n - 2; i >= 0; i-- {
		for j := m - 2; j >= 0; j-- {
			if mat[i][j] != 0 {
				mat[i][j] = min(mat[i][j], min(mat[i+1][j], mat[i][j+1])+1)
			}
		}
	}

	return mat
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}
