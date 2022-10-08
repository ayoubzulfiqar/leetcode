package main

import "sort"

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

func threeSumClosest(nums []int, target int) int {
	l := len(nums)
	sort.Slice(nums, func(i, j int) bool { return nums[i] < nums[j] })

	// take arbitrary sum as closest
	closest := nums[0] + nums[1] + nums[2]

	for i := 0; i < l-2; i++ {
		// ideal sum for (2nd+3rd)
		c := target - nums[i]
		// start looking at ends
		l, h := i+1, l-1
		for l < h {
			v := nums[l] + nums[h]
			w := nums[i] + v
			// for each three numbers check if their sum is smaller than current closest number
			if abs(target-w) < abs(target-closest) {
				closest = w
			}
			if v > c {
				// if sum of (2nd+3rd) is larger that ideal, try to decrease it
				h--
			} else if v < c {
				// if sum of (2nd+3rd) is smaller than ideal, try to increase it
				l++
			} else {
				// we found exact match, bail out
				return target
			}
		}
	}

	return closest
}
