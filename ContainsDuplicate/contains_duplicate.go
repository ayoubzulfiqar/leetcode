package main

func containsDuplicate(nums []int) bool {
	if len(nums) == 0 {
		return true
	}
	for i := 0; i < len(nums); i++ {
		for j := i + 1; j < len(nums); j++ {
			if nums[i] == nums[j] {
				return true
			}
		}
	}
	return false
}
