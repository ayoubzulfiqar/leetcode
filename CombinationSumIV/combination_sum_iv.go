package main

import "sort"

func helper(nums []int, n int, memo map[int]int) int {
	if val, found := memo[n]; found {
		return val
	}
	if n == 0 {
		return 1
	}
	if n < nums[0] {
		return 0
	}

	count := 0
	for _, num := range nums {
		if n-num < 0 {
			break
		}
		count += helper(nums, n-num, memo)
	}

	memo[n] = count
	return count
}

func combinationSum4(nums []int, target int) int {
	sort.Ints(nums)
	memo := make(map[int]int)
	return helper(nums, target, memo)
}
