package main

import "math"

var mem [][]int

func max(x, y int) int {
	if x > y {
		return x
	}
	return y
}

func min(x, y int) int {
	if x < y {
		return x
	}
	return y
}

func minDifficulty(jd []int, d int) int {
	if d > len(jd) {
		return -1
	}

	mem = make([][]int, len(jd))
	for i := 0; i < len(mem); i++ {
		mem[i] = make([]int, d+1)
		for j := range mem[i] {
			mem[i][j] = -1
		}
	}

	return dp(jd, 0, d)
}

func dp(jd []int, start, day int) (ans int) {
	if mem[start][day] != -1 {
		return mem[start][day]
	}
	defer func() { mem[start][day] = ans }()

	if day == 1 {
		ans = jd[start]
		for i := start; i < len(jd); i++ {
			ans = max(jd[i], ans)
		}
		return
	}

	curMax := -1
	ans = math.MaxInt32
	for i := start; len(jd)-i > day-1; i++ {
		curMax = max(curMax, jd[i])
		result := curMax + dp(jd, i+1, day-1)
		ans = min(ans, result)
	}
	return ans
}
