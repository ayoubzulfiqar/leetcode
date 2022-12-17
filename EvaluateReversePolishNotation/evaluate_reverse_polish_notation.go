package main

import "strconv"

var m = map[string]func(int, int) int{
	"+": func(lhs, rhs int) int { return lhs + rhs },
	"-": func(lhs, rhs int) int { return lhs - rhs },
	"*": func(lhs, rhs int) int { return lhs * rhs },
	"/": func(lhs, rhs int) int { return lhs / rhs },
}

func evalRPN(tokens []string) int {
	var stk []int
	for _, val := range tokens {
		var num int
		if fn, ok := m[val]; ok {
			var lhs, rhs int
			stk, lhs, rhs = popTopTwo(stk)
			num = fn(lhs, rhs)
		} else {
			num, _ = strconv.Atoi(val)
		}

		stk = append(stk, num)
	}

	return stk[0]
}

func popTopTwo(stk []int) ([]int, int, int) {
	rhs := stk[len(stk)-1]
	stk = stk[:len(stk)-1]

	lhs := stk[len(stk)-1]
	stk = stk[:len(stk)-1]

	return stk, lhs, rhs
}
