package main

import "math"

func maxValue(n, index, maxSum int) int {
	maxSum -= n
	left := index + 1
	right := n - index

	small := min(left, right)
	large := max(left, right)

	a := s(large, large) + s(large, small) - large
	if maxSum >= a {
		return large + (maxSum-a)/n + 1
	}

	b := s(small, small)*2 - small
	if maxSum >= b {
		return small + findExtra(small*2, 1, maxSum-b) + 1
	}

	return findExtra(1, 2, maxSum) + 1
}

func s(h, l int) int {
	return (2*h - l + 1) * l / 2
}

func findExtra(start, increment, maxSum int) int {
	b := start*2/increment - 1
	c := 2 * maxSum / increment

	d := int(math.Sqrt(float64(b*b + 4*c)))
	n := (d - b) / 2
	return n
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}
