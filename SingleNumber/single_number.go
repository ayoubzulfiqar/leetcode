package main

import "sort"

func singleNumber(nums []int) int {
	var ones int = 0
	var twos int = 0

	for i := 0; i < len(nums); i++ {
		var number int = nums[i]
		ones ^= (number & ^twos)
		twos ^= (number & ^ones)
	}

	return ones
}

func anotherSingle(nums []int) int {
	var index int = len(nums) - 1
	sort.Ints(nums)
	var value int = 0
	for value < index {
		if nums[value] != nums[value+1] {
			return nums[value]
		} else {

			value += 2
		}
		if index%2 == 1 {
			return nums[index]
		}
	}
	return -1
}
