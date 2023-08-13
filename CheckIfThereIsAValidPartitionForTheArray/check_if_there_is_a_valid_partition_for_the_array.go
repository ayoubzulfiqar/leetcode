package main

func validPartition(nums []int) bool {
	n := len(nums)
	vp := make([]bool, n+1)
	vp[0] = true

	if nums[1] == nums[0] {
		vp[2] = true
	}
	for i := 2; i < n; i++ {
		if nums[i] == nums[i-1] {
			vp[i+1] = vp[i+1] || vp[i-1]
		}
		if nums[i] == nums[i-1] && nums[i] == nums[i-2] {
			vp[i+1] = vp[i+1] || vp[i-2]
		}
		if nums[i] == nums[i-1]+1 && nums[i] == nums[i-2]+2 {
			vp[i+1] = vp[i+1] || vp[i-2]
		}
	}
	return vp[n]
}
