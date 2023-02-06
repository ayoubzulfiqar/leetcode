package main

import "math"

func shuffle(nums []int, n int) []int {
	nums[0] *= -1
	for i := 1; i < len(nums); i++ {

		var j int = i
		var currentNumber int = nums[i]
		for nums[j] > 0 {
			var target int
			if j < n {
				target = j * 2
			} else {
				target = (j-n)*2 + 1
			}
			var temp int = nums[target]
			nums[target] = currentNumber
			currentNumber = temp
			nums[j] *= -1
			j = target
		}
	}
	for i := 0; i < len(nums); i++ {
		nums[i] = int(math.Abs(float64(nums[i])))
	}
	return nums
}
