package main

import "math"

func ToFloat64(in int) float64 {
	return float64(in)
}
func minimumAverageDifference(nums []int) int {
	// if there is only one element then itself would be the ans (index 0).
	if len(nums) == 1 {
		return 0
	}
	// finding total sum of vector (using int int to prevent overflow)
	var sum int = 0

	for _, a := range nums {
		sum += a
	}
	//initially left side sum will be zero and right side sum will be total sum
	var leftSum int = 0
	var rightSum int = sum
	// this will be used to keep track of minimum
	var avgDiff float64
	var mini int = -1
	var minIndex int = -1
	var n = len(nums)
	for i := 0; i < n-1; i++ {
		// increasing left sum and decreasing right sum
		leftSum += nums[i]
		rightSum -= nums[i]
		// finding avgDiff ,  (here (n-i-1) represents element count in right part, ans (i+1) in left part)
		avgDiff = math.Abs(ToFloat64((leftSum / (i + 1)) - (rightSum / (n - i - 1))))
		//updating mini
		if mini == -1 {
			mini = int(avgDiff)
			minIndex = i
		} else if mini > int(avgDiff) {
			mini = int(avgDiff)
			minIndex = i
		}
	}
	// check for last element
	avgDiff = math.Round(ToFloat64(sum / n))
	if mini > int(avgDiff) {
		mini = int(avgDiff)
		minIndex = n - 1
	}
	return minIndex
}
