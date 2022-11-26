package main

import "sort"

func jobScheduling(startTime []int, endTime []int, profit []int) int {
	// Initialize jobs array
	type Job struct {
		start, end, profit int
	}
	jobs := make([]Job, len(startTime))
	for i := 0; i < len(startTime); i++ {
		jobs[i] = Job{startTime[i], endTime[i], profit[i]}
	}
	// Sort it on start time
	sort.Slice(jobs, func(i, j int) bool { return jobs[i].start < jobs[j].start })

	nonConflictingJob := func(i int) int {
		left, right := i+1, len(jobs)-1
		for left <= right {
			mid := (left + right) / 2
			if jobs[mid].start >= jobs[i].end {
				left, right = left, mid-1
			} else {
				left, right = mid+1, right
			}
		}
		return left
	}

	memo := make(map[int]int) // Profit that can be made at position
	var dfs func(int) int
	dfs = func(pos int) int {
		// Exit condition
		if pos == len(jobs) {
			return 0
		}
		// Memoized branch
		if ans, ok := memo[pos]; ok {
			return ans
		}
		// Work branch
		var ans int
		ans += jobs[pos].profit
		ans += dfs(nonConflictingJob(pos))
		ans2 := dfs(pos + 1)
		if ans < ans2 {
			ans = ans2
		}
		memo[pos] = ans
		return ans
	}

	return dfs(0)
}
