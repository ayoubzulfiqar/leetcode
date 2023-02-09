package main

func jump(nums []int) int {
	if len(nums) == 1 {
		return 0
	}
	var maximum int = 0
	var current int = 0
	var count int = 0
	for i := 0; i < len(nums)-1; i++ {
		maximum = max(maximum, i+nums[i])
		if current == i {
			current = maximum
			count++
		}
		if current > len(nums)-1 {
			return count
		}
	}
	return count
}

func max(a int, b int) int {
	if a > b {
		return a
	}
	return b
}
