package main

import "math"

func increasingTriplet(nums []int) bool {
	length := len(nums)
	if length < 3 {
		return false
	}

	first := nums[0]
	second := math.MaxInt32

	for i := 1; i < length; i++ {
		num := nums[i]
		if num > second {
			return true
		} else if num > first {
			second = num
		} else {
			first = num
		}
	}

	return false
}
