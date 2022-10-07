package main

import "fmt"

func summaryRanges(nums []int) []string {
	ans := []string{}
	if len(nums) == 0 {
		return ans
	}
	nums = append(nums, nums[len(nums)-1]+2)
	start := nums[0]
	for i := 1; i < len(nums); i++ {
		if nums[i]-nums[i-1] > 1 {
			if nums[i-1] == start {
				ans = append(ans, fmt.Sprintf("%d", start))
			} else {
				ans = append(ans, fmt.Sprintf("%d->%d", start, nums[i-1]))
			}
			start = nums[i]
		}
	}
	return ans

}
