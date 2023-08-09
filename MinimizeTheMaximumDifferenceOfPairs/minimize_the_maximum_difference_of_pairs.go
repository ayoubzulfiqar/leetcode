package main

import "sort"

func solve(nums []int, mid int) int {
	pairs := 0
	for j := 0; j+1 < len(nums); j++ {
		if nums[j+1]-nums[j] <= mid {
			pairs++
			j++
		}
	}
	return pairs
}

func minimizeMax(nums []int, p int) int {
	sort.Ints(nums)
	sols := 0
	low, high := 0, nums[len(nums)-1]
	for low <= high {
		mid := (high + low) / 2
		pairs := solve(nums, mid)
		if pairs >= p {
			sols = mid
			high = mid - 1
		} else {
			low = mid + 1
		}
	}
	return sols
}
