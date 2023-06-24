package main

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func abs(num int) int {
	if num < 0 {
		return -num
	}
	return num
}

func copyFrom(dp map[int]int) map[int]int {
	newDP := make(map[int]int)
	for key, value := range dp {
		newDP[key] = value
	}

	return newDP
}

func tallestBillboard(rods []int) int {
	dp := map[int]int{
		0: 0,
	}

	for _, rod := range rods {
		newDP := copyFrom(dp)

		for diff, taller := range dp {
			shorter := taller - diff
			newTaller := newDP[diff+rod]
			newDP[diff+rod] = max(newTaller, taller+rod)
			newDiff := abs(shorter + rod - taller)
			newTaller2 := max(shorter+rod, taller)
			newDP[newDiff] = max(newTaller2, newDP[newDiff])
		}

		dp = newDP
	}

	return dp[0]
}
