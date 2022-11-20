package main

import "strings"

func calculate(s string) int {
	// for easier code, remove all blank and append a ")"
	s = strings.ReplaceAll(s, " ", "") + ")"
	result, _ := calcUntilBrackets(s, 0)
	return result
}

// return calc result and endIndex
func calcUntilBrackets(s string, startIndex int) (int, int) {
	calcResult := 0
	current := 0
	sign := 1
	for i := startIndex; i < len(s); i++ {
		v := s[i]
		if v >= '0' && v <= '9' {
			current = current*10 + int(v-'0')
			continue
		}

		calcResult += current * sign
		current = 0

		if v == '(' {
			inner, bracket := calcUntilBrackets(s, i+1)
			i = bracket
			calcResult += inner * sign
		} else if v == ')' {
			return calcResult, i
		} else if v == '+' {
			sign = 1
		} else if v == '-' {
			sign = -1
		}
	}
	// code reach here is impossible
	return calcResult, -1
}
