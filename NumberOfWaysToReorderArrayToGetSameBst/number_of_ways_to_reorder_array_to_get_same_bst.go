package main

var pascal [][]int

func numOfWays() {

	// Initialize the Pascal triangle.
	for i := 0; i <= 100; i++ {
		pascal = append(pascal, make([]int, i+1))
		for j := 0; j <= i; j++ {
			if j == 0 || j == i {
				pascal[i][j] = 1
			} else {
				pascal[i][j] = (pascal[i-1][j] + pascal[i-1][j-1]) % (1e9 + 7)
			}
		}
	}

}

func dfs(nums []int) int {
	n := len(nums)
	if n <= 2 {
		return 1
	}

	left := make([]int, 0)
	right := make([]int, 0)
	for i := 1; i < n; i++ {
		if nums[i] < nums[0] {
			left = append(left, nums[i])
		} else {
			right = append(right, nums[i])
		}
	}

	return (dfs(left) * pascal[n-1][len(left)]) % (1e9 + 7) * dfs(right) % (1e9 + 7)
}
