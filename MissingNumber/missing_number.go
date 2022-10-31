package main

func missingNumber(nums []int) int {
	var sum int = 0
	var total int = len(nums) * (len(nums) + 1) / 2
	for i := 0; i < len(nums); i++ {
		sum += nums[i]
	}
	return total - sum
}
