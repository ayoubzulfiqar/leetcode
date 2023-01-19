package main

func subarraysDivByK(nums []int, k int) int {
	var mp map[int]int = make(map[int]int)
	var ans int
	var sum int
	for i := 0; i < len(nums); i++ {
		sum = (sum + nums[i]) % k
		if sum < 0 {
			sum = (sum + k) % k
		}
		if sum == 0 {
			ans++
		}
		if mp[sum] != 0 {
			ans += mp[sum]
			mp[sum]++
		} else {
			mp[sum] = 1
		}
	}
	return ans
}
