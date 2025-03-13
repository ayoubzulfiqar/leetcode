package main

import "math"

func reverse(x int) int {

	var neg bool
	if x < 0 {
		neg = true
		x = x * -1
	}

	revX := getReversed(x)
	if neg == true {
		return revX * -1
	}
	return revX
}

func getReversed(x int) int {
	var rev, lastDigit int
	for x > 0 {
		lastDigit = x % 10
		x = x / 10
		rev = rev*10 + lastDigit
	}
	if rev > (math.MaxInt32) {
		return 0
	}
	return rev
}
