package main

import "math"

func minFallingPathSum(A [][]int) int {
	m, n := len(A), len(A[0])
	dp := make([][]int, m)
	for i := 0; i < m; i++ {
		dp[i] = make([]int, n)
		for j := 0; j < n; j++ {
			if i == 0 {
				dp[i][j] = A[i][j]
			} else {
				min := math.MaxInt32
				offset := []int{-1, 0, 1}
				for k := 0; k < len(offset); k++ {
					if j+offset[k] < n && j+offset[k] >= 0 && dp[i-1][j+offset[k]] < min {
						min = dp[i-1][j+offset[k]]
					}
				}
				dp[i][j] = A[i][j] + min
			}
		}
	}
	res := math.MaxInt32
	for i := 0; i < n; i++ {
		if dp[m-1][i] < res {
			res = dp[m-1][i]
		}
	}
	return res
}
