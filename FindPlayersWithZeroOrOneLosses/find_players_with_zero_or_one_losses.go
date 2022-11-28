package main

func findWinners(matches [][]int) [][]int {
	// fixed length of winners
	var won []int = make([]int, 100001)
	// fixed length of the loser
	var loss []int = make([]int, 100001)
	// for in loop
	for _, match := range matches {
		won[match[0]]++
		loss[match[1]]++
	}
	// 2D Array
	var ans [][]int
	// List of who won the math
	var wonAllMatches []int
	// list of who lose the match
	var lostOneMatch []int

	// looping through the lit of winners
	for i := 0; i < len(won); i++ {
		// if the winner value at i is greater than zeo and loser value is equal to zero
		if won[i] > 0 && loss[i] == 0 {
			// we will add winner value to winner list
			wonAllMatches = append(wonAllMatches, i)
		}

		// if loser value is equal to one like we have a loser
		if loss[i] == 1 {
			// we will add that value to our list
			lostOneMatch = append(lostOneMatch, i)

		}
	}
	// at the end we will add both of winner and loser list into result list
	ans = append(ans, wonAllMatches)
	ans = append(ans, lostOneMatch)
	return ans
}
