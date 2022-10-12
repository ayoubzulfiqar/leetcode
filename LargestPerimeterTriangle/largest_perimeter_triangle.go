package main

import "sort"

func largestPerimeter(nums []int) int {
	sort.Slice(nums, func(i, j int) bool {
		return nums[i] > nums[j]
	})
	for i := 0; i < len(nums)-2; i++ {
		a := nums[i]
		b := nums[i+1]
		c := nums[i+2]
		if a < (b + c) {
			return a + b + c
		}
	}
	return 0
}
