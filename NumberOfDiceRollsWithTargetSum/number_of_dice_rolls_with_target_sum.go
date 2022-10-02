package main

// func solve(n int, k int, target int) int {
// 	if n == 0 && target == 0 {
// 		return 1
// 	}

// 	if n <= 0 || target <= 0 {
// 		return 0
// 	}

// 	ans := 0
// 	for i := 1; i <= k; i++ {
// 		ans += solve(n-1, k, target-i)
// 	}

// 	return ans
// }

// func numRollsToTarget(n int, k int, target int) int {
// 	return solve(n, k, target)
// }

func numRollsToTarget(n int, k int, target int) int {
	const mod int = 1e9 + 7
	var ans [1001]int
	for i := 1; i <= k; i++ {
		ans[i] = 1
	}
	for n--; n > 0; n-- {
		var last, sum = ans, 0
		for i := 1; i <= target; i++ {
			sum += last[i-1]
			if i-k-1 > 0 {
				sum -= last[i-k-1]
			}
			ans[i] = sum % mod
		}
	}
	return ans[target]
}
