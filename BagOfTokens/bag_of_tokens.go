package main

import "sort"

func bagOfTokensScore(tokens []int, P int) int {
	// to hold the value  of our score
	var score int = 0
	// sorting the token and slicing because sort.slice is more stable
	sort.Slice(tokens, func(i, j int) bool { return tokens[i] < tokens[j] })
	// loop if the token length is greater than 0 abd power is also greater and equal
	// than the first value of the token list
	for len(tokens) > 0 && P >= tokens[0] {
		// we will decrement the first value of token from the power
		P = P - tokens[0]
		// increment the score because we point a score
		score++
		tokens = tokens[1:]
		// if the length of the list of tokens is more than 1 and power is less than first value of the list
		if len(tokens) > 1 && P < tokens[0] {
			// than we will increment the value of power inside the first index of the token
			P = P + tokens[len(tokens)-1]
			// we will decrement the score
			score--
			tokens = tokens[:len(tokens)-1]
		}
	}
	// than we will total score we have achieved
	return score
}
