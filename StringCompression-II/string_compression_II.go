package main

import "math"

type State struct {
	idx           int
	lastChar      byte
	lastCharCount int
	k             int
}

func getLengthOfOptimalCompression(s string, k int) int {
	m := make(map[State]int)
	return dp(0, 'a'-1, 0, k, m, s)
}

func dp(idx int, lastChar byte, lastCharCount int, k int, m map[State]int, s string) int {
	state := State{idx, lastChar, lastCharCount, k}
	if v, ok := m[state]; ok {
		return v
	}

	if k < 0 {
		return math.MaxInt
	}

	if idx == len(s) {
		return 0
	}

	var keepChar int
	deleteChar := dp(idx+1, lastChar, lastCharCount, k-1, m, s)
	if s[idx] == lastChar {
		keepChar = dp(idx+1, lastChar, lastCharCount+1, k, m, s)
		if lastCharCount == 1 || lastCharCount == 9 || lastCharCount == 99 {
			keepChar++
		}
	} else {
		keepChar = dp(idx+1, s[idx], 1, k, m, s) + 1
	}

	minV := min(keepChar, deleteChar)
	m[state] = minV
	return minV
}

func min(x, y int) int {
	if x < y {
		return x
	}
	return y
}
