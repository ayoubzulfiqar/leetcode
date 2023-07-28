package main


/* 
Slow BitMask
func PredictTheWinner(arr []int) bool {
	if len(arr) <= 1 {
		return true
	}
	dp := make([]int, 1<<len(arr))
	tar := 0
	for i := 0; i < len(arr); i++ {
		tar += 1 << i
	}
	val := solve(arr, 0, dp, tar)
	return val >= 0
}

func solve(arr []int, current int, dp []int, tar int) int {
	if current == tar {
		return 0 // all integers have been picked
	}
	if dp[current] != 0 {
		return dp[current] // cache
	}
	// max := math.MinInt32
	max := -2147483648

	for i := 0; i < len(arr); i++ {
		// finding first unpicked integer
		if current&(1<<i) == 0 {
			max = _max(max, arr[i]-solve(arr, (current|(1<<i)), dp, tar))
			break
		}
	}

	for i := len(arr) - 1; i >= 0; i-- {
		// finding last unpicked integer
		if current&(1<<i) == 0 {
			max = _max(max, arr[i]-solve(arr, (current|(1<<i)), dp, tar))
			break
		}
	}
	dp[current] = max
	return max
}

func _max(a, b int) int {
	if a > b {
		return a
	}
	return b
}




// Dynamic Programming

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func PredictTheWinner(nums []int) bool {
	n := len(nums)
	dp := make([][]int, n)
	for i := 0; i < n; i++ {
		dp[i] = make([]int, n)
	}

	for i := n - 1; i >= 0; i-- {
		for j := i; j < n; j++ {
			if i == j {
				dp[i][j] = nums[i]
			} else {
				dp[i][j] = max(nums[i]-dp[i+1][j], nums[j]-dp[i][j-1])
			}
		}
	}

	return dp[0][n-1] >= 0
}


*/





func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func PredictTheWinner(nums []int) bool {
	n := len(nums)
	t := make([][]int, n+1)
	for i := 0; i <= n; i++ {
		t[i] = make([]int, n+1)
		for j := 0; j <= n; j++ {
			t[i][j] = -1
		}
	}
	rangeSum := 0
	for _, n := range nums {
		rangeSum += n
	}

	max1 := maxPosAmount(nums, 0, n-1, t)
	max2 := rangeSum - max1
	return max1 >= max2
}

func maxPosAmount(nums []int, i, j int, t [][]int) int {
	if i > j || i < 0 || j >= len(nums) || i >= len(nums) || j < 0 {
		return 0
	}
	if t[i][j] != -1 {
		return t[i][j]
	}
	f1 := nums[i] + min(maxPosAmount(nums, i+1, j-1, t), maxPosAmount(nums, i+2, j, t))
	f2 := nums[j] + min(maxPosAmount(nums, i, j-2, t), maxPosAmount(nums, i+1, j-1, t))
	t[i][j] = max(f1, f2)
	return t[i][j]
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}






