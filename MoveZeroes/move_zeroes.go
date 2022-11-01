package main

func moveZeroes(nums []int) {
	var left int = 0
	var right int = 1
	for left < len(nums) && right < len(nums) {
		if nums[left] == 0 && nums[right] != 0 {
			var temp int = nums[left]
			nums[left] = nums[right]
			nums[right] = temp
		} else if nums[left] == 0 && nums[right] == 0 {
			right++
		} else if nums[left] != 0 {
			right++
			left++
		} else {
			left++
		}
	}

}
