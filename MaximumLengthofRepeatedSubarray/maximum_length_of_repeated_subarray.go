package main

// DP
// func findLength(A []int, B []int) int {
// 	dp := make([][]int, len(A)+1)
// 	for i := range dp {
// 		dp[i] = make([]int, len(B)+1)
// 	}
// 	max := 0
// 	for i, a := range A {
// 		for j, b := range B {
// 			if a == b {
// 				dp[i+1][j+1] = dp[i][j] + 1
// 				if dp[i+1][j+1] > max {
// 					max = dp[i+1][j+1]
// 				}
// 			}
// 		}
// 	}
// 	return max
// }

// Brute Force
func findLength(A []int, B []int) int {
	maxLength := 0
	for i := 0; i < len(A); i++ {
		indexA := i
		indexB := 0
		current := 0
		for indexA < len(A) && indexB < len(B) {
			if A[indexA] == B[indexB] {
				current++
				if current > maxLength {
					maxLength = current
				}
			} else {
				current = 0
			}
			indexA++
			indexB++
		}
	}
	for i := 0; i < len(B); i++ {
		indexA := 0
		indexB := i
		current := 0
		for indexA < len(A) && indexB < len(B) {
			if A[indexA] == B[indexB] {
				current++
				if current > maxLength {
					maxLength = current
				}
			} else {
				current = 0
			}
			indexA++
			indexB++
		}
	}
	return maxLength
}
