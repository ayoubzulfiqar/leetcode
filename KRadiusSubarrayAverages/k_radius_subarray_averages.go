package main

func getAverages(nums []int, k int) []int {
	n := len(nums)
	windowSize := 2*k + 1

	var windowSum int64
	result := make([]int, n)
	for i := 0; i < n; i++ {
		result[i]=-1
		windowSum += int64(nums[i])

		if i >= windowSize {
			windowSum -= int64(nums[i-windowSize])
		}

		if i >= windowSize-1 {
			result[i-k] = int(windowSum / int64(windowSize))
		}
	}

	return result
}
