package main

import (
	"math"
	"sort"
)

func makeArrayIncreasing(arr1 []int, arr2 []int) int {
	n := len(arr1)

	sort.Ints(arr2)
	uniqueArr2 := []int{}
	for i := 0; i < len(arr2); i++ {
		if i+1 < len(arr2) && arr2[i] == arr2[i+1] {
			continue
		}
		uniqueArr2 = append(uniqueArr2, arr2[i])
	}
	arr2 = uniqueArr2

	newArr1 := make([]int, n+2)
	for i := 0; i < n; i++ {
		newArr1[i+1] = arr1[i]
	}
	newArr1[n+1] = math.MaxInt32
	newArr1[0] = math.MinInt32
	arr1 = newArr1

	dp := make([]int, n+2)
	for i := 0; i < n+2; i++ {
		dp[i] = math.MaxInt32
	}
	dp[0] = 0
	for i := 1; i < n+2; i++ {
		for j := 0; j < i; j++ {
			if arr1[j] < arr1[i] && dp[j] != math.MaxInt32 {
				change := check(arr1, arr2, j, i)
				if change >= 0 {
					dp[i] = min(dp[i], dp[j]+change)
				}
			}
		}
	}
	if dp[n+1] == math.MaxInt32 {
		return -1
	}
	return dp[n+1]
}

func check(arr1 []int, arr2 []int, start int, end int) int {
	if start+1 == end {
		return 0
	}
	minVal := arr1[start]
	maxVal := arr1[end]
	idx := sort.Search(len(arr2), func(i int) bool { return arr2[i] > minVal })
	maxCount := end - start - 1
	endIdx := idx + maxCount - 1
	if endIdx < len(arr2) && arr2[endIdx] < maxVal {
		return maxCount
	} else {
		return -1
	}
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}
