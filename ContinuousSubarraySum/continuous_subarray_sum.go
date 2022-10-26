package main

func checkSubarraySum(nums []int, k int) bool {
	res := 0
	var m map[int]int
	m = make(map[int]int)
	for i := 0; i < len(nums); i++ {
		res = (res + nums[i]) % k
		if i > 0 && res == 0 {
			return true
		}
		if m[res] != 0 {
			if i+1-m[res] > 1 {
				return true
			}
		} else {
			m[res] = i + 1
		}
	}
	return false
}
