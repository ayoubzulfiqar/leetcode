package main

import "sort"

func min(a, b int) int {
	if a <= b {
		return a
	}
	return b
}

func max(a, b int) int {
	if a >= b {
		return a
	}
	return b
}

func insert(intervals [][]int, newInterval []int) [][]int {
	idx := sort.Search(len(intervals), func(i int) bool {
		return intervals[i][1] >= newInterval[0]
	})
	idx2 := sort.Search(len(intervals), func(i int) bool {
		return intervals[i][0] > newInterval[1]
	})
	if idx == idx2 && (idx == len(intervals) || newInterval[1] < intervals[idx][0]) {
		result := make([][]int, len(intervals)+1)
		copy(result, intervals[:idx])
		result[idx] = newInterval
		copy(result[idx+1:], intervals[idx:])
		return result
	}
	intervals[idx][0] = min(intervals[idx][0], newInterval[0])
	intervals[idx][1] = max(intervals[idx2-1][1], newInterval[1])
	if diff := idx2 - idx; diff > 1 {
		copy(intervals[idx+1:], intervals[idx2:])
		intervals = intervals[:len(intervals)-(diff-1)]
	}
	return intervals
}
