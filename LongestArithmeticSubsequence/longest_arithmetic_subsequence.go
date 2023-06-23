package main

import "sort"

func longestArithSeqLength(nums []int) int {
	hash := make(map[int][]int)
	for i, num := range nums {
		hash[num] = append(hash[num], i)
	}

	maxCount := 0
	for i := 0; i < len(nums); i++ {
		for j := i + 1; j < len(nums); j++ {
			d := nums[j] - nums[i]
			ls := nums[j]
			cnt := 2
			li := j
			for ls >= 0 {
				v := hash[ls+d]
				if d == 0 {
					cnt = len(v)
					break
				}
				ind := sort.Search(len(v), func(k int) bool { return v[k] > li })
				if ind >= len(v) {
					break
				}
				cnt++
				ls += d
				li = v[ind]
			}
			if cnt > maxCount {
				maxCount = cnt
			}
		}
	}
	return maxCount
}
