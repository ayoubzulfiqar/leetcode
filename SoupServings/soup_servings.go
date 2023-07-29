package main

/* Recursion is Still BAD in GO - TLE
func soupServings(n int) float64 {
	ans := solve(n, n)
	return ans
}

func solve(soupA, soupB int) float64 {
	if soupA <= 0 && soupB <= 0 {
		return 0.5
	}
	if soupA <= 0 {
		return 1.0
	}
	if soupB <= 0 {
		return 0.0
	}

	var prob float64
	prob += 0.25 * solve(soupA-100, soupB)
	prob += 0.25 * solve(soupA-75, soupB-25)
	prob += 0.25 * solve(soupA-50, soupB-50)
	prob += 0.25 * solve(soupA-25, soupB-75)

	return prob
}
*/

/*
// Memoization + DP

func soupServings(n int) float64 {
	if n > 5000 {
		// If n is greater than 5000, the probability is very close to 1.0.
		return 1.0
	}

	// Use a map to store memoized results.
	memo := make(map[[2]int]float64)
	ans := solve(n, n, memo)
	return ans
}

func solve(soupA, soupB int, memo map[[2]int]float64) float64 {
	if soupA <= 0 && soupB <= 0 {
		return 0.5
	}
	if soupA <= 0 {
		return 1.0
	}
	if soupB <= 0 {
		return 0.0
	}

	// Check if the result is already memoized.
	if val, ok := memo[[2]int{soupA, soupB}]; ok {
		return val
	}

	var prob float64
	prob += 0.25 * solve(soupA-100, soupB, memo)
	prob += 0.25 * solve(soupA-75, soupB-25, memo)
	prob += 0.25 * solve(soupA-50, soupB-50, memo)
	prob += 0.25 * solve(soupA-25, soupB-75, memo)

	// Memoize the result before returning.
	memo[[2]int{soupA, soupB}] = prob

	return prob
}

*/

func soupServings(n int) float64 {
	if n > 5000 {
		return 1.0
	}

	// Initialize dp memoization
	dp := make([][]float64, 200)
	for i := 0; i < 200; i++ {
		dp[i] = make([]float64, 200)
	}

	// Define the recursive function depthFirstSearch
	var depthFirstSearch func(soupA, soupB int) float64
	depthFirstSearch = func(soupA, soupB int) float64 {
		if soupA <= 0 && soupB <= 0 {
			return 0.5
		} else if soupA <= 0 {
			return 1.0
		} else if soupB <= 0 {
			return 0.0
		}

		if dp[soupA][soupB] > 0 {
			return dp[soupA][soupB]
		}

		dp[soupA][soupB] = 0.25 * (depthFirstSearch(soupA-4, soupB) + depthFirstSearch(soupA-3, soupB-1) + depthFirstSearch(soupA-2, soupB-2) + depthFirstSearch(soupA-1, soupB-3))
		return dp[soupA][soupB]
	}

	// Call dfs and return the result
	return depthFirstSearch((n+24)/25, (n+24)/25)
}
