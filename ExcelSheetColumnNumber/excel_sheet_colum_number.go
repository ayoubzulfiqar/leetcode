package main

import (
	"math"
	"strings"
)

func titleToNumber(columnTitle string) int {
	result := 0.0
	s := strings.ToLower(columnTitle)
	size := len(s)
	for i := 0; i < size; i++ {
		num := s[i] % 96
		n := size - 1 - i
		result += math.Pow(float64(26), float64(n)) * float64(num)
	}
	return int(result)
}
