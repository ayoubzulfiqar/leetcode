package main

func findSubsequences(nums []int) (res [][]int) {
	var dfs func(int, []int)
	dfs = func(l int, sl []int) {
		if len(sl) > 1 {
			cp := make([]int, len(sl))
			copy(cp, sl)
			res = append(res, cp)
		}
		seen := make(map[int]bool, len(nums)-l)
		for r := l; r < len(nums); r++ {
			if (l > 0 && nums[r] < nums[l-1]) || seen[nums[r]] {
				continue
			}
			seen[nums[r]] = true
			dfs(r+1, append(sl, nums[r]))
		}
	}

	dfs(0, []int{})

	return res
}
