package main

func minimumReplacement(nums []int) int64 {
	n := len(nums)

	if n == 1 {
		return 0
	}

	return helper(n-1, nums, 0, n)
}

func helper(index int, nums []int, min int, n int) int64 {
	if index == n-1 {
		return helper(index-1, nums, nums[index], n)
	} else {
		ec := 0
		if nums[index] > min {
			if nums[index]%min == 0 {
				ec = nums[index] / min
			} else {
				ec = nums[index]/min + 1
			}

			nMin := nums[index] / ec
			lc := int64(ec)

			if index == 0 {
				return lc - 1
			} else {
				return lc - 1 + helper(index-1, nums, nMin, n)
			}
		} else {
			if index == 0 {
				return 0
			} else {
				return helper(index-1, nums, nums[index], n)
			}
		}
	}
}
