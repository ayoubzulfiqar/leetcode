package main

import "strconv"

func numDecodings(s string) int {
	sol := Solution{mp: map[string]int{}}
	return sol.Decode(s)
}

type Solution struct {
	mp map[string]int
}

func (sol *Solution) Decode(s string) int {
	if n, ok := sol.mp[s]; ok {
		return n
	}
	if len(s) <= 1 && s != "0" {
		return 1
	}
	if s[0] == '0' {
		return 0
	}
	num := sol.Decode(s[1:])
	if n, _ := strconv.Atoi(s[:2]); n >= 10 && n <= 26 {
		num += sol.Decode(s[2:])
	}
	sol.mp[s] = num
	return num
}

/*
Iterative
func numDecodings(s string) int {
	if s == "0" {
		return 0
	}
	if len(s) <= 1 {
		return 1
	}
	dp := make([]int, len(s)+1)
	dp[0], dp[1] = 1, 1
	if s[0] == '0' {
		dp[1] = 0
	}
	for i := 2; i <= len(s); i++ {
		if single, _ := strconv.Atoi(s[i-1 : i]); single > 0 {
			dp[i] = dp[i-1]
		}
		if double, _ := strconv.Atoi(s[i-2 : i]); double >= 10 && double <= 26 {
			dp[i] += dp[i-2]
		}
	}
	return dp[len(s)]
}
*/
