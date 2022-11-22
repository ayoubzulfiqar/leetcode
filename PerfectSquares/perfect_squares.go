package main

import "math"

func numSquares(n int) int {
	// Four-square and three-square theorems.
	if isSquare(n) {
		return 1
	}
	for n&3 == 0 { // n % 4 == 0
		n >>= 2 // n /= 4
	}
	if n&7 == 7 { // n % 8 == 7
		return 4
	}

	// Check if the number can be decomposed into sum of two squares.
	for i := 1; i*i <= n; i++ {
		if isSquare(n - i*i) {
			return 2
		}
	}
	// Bottom case of three-square theorem.
	return 3
}

func isSquare(n int) bool {
	var squareRootN int = (int)(math.Sqrt(float64(n)))
	return squareRootN*squareRootN == n
}
