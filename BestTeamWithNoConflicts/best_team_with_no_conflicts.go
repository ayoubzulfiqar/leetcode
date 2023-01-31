package main

import "sort"

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func bestTeamScore(scores []int, ages []int) int {
	var n int = len(ages)
	player := [][]int{}
	for i := 0; i < n; i++ {
		player = append(player, []int{ages[i], scores[i]})
	}
	sort.Slice(player, func(i, j int) bool {
		return player[i][0] < player[j][0] || (player[i][0] == player[j][0] && player[i][1] < player[j][1])
	})
	var ans int = 0
	DP := make([]int, n+1)
	for i := 0; i < n; i++ {
		DP[i+1] = player[i][1]
		for j := 0; j < i; j++ {
			if player[j][1] > player[i][1] {
				continue
			}
			DP[i+1] = max(DP[i+1], player[i][1]+DP[j+1])
		}
		ans = max(ans, DP[i+1])
	}
	return ans
}
