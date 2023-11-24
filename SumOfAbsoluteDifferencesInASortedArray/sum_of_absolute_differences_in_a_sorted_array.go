package main

func getSumAbsoluteDifferences(nums []int) []int {
	var x, y int = 0, 0
	var len int = len(nums)

	for i := 0; i < len; i++ {
		y += nums[i]
	}

	for i := 0; i < len; i++ {
		x += nums[i]
		tmp := (nums[i]*(i+1) - x) + (y - nums[i]*(len-i))

		y -= nums[i]
		nums[i] = tmp
	}

	return nums
}
