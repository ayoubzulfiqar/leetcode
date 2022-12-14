package main

func rob(nums []int) int {
	//max money can get if rob current house
	var previous int = 0
	//max money can get if not rob current house
	var last int = 0
	//if rob current value, previous house must not be robbed
	for i := 0; i < len(nums); i++ {
		var current int = last + nums[i]
		//if not rob ith house, take the max value of robbed (i-1)th house and not rob (i-1)th house
		last = max(last, previous)
		previous = current
	}
	return max(previous, last)
}

func max(a int, b int) int {
	if a > b {
		return a
	} else {
		return b
	}
}
