package main

import "sort"

// func maxIceCream(costs []int, coins int) int {
// 	sort.Ints(costs)
// 	var size int = len(costs)
// 	var answer int = 0
// 	for i := 0; i < size; i++ {
// 		if answer+costs[i] > coins {
// 			return i
// 		}
// 		answer += costs[i]
// 	}
// 	return len(costs)
// }
func maxIceCream(costs []int, coins int) int {
	sort.Ints(costs)
	var result int = 0
	var sum int = 0
	for _, cost := range costs {
		sum += cost
		if sum > coins {
			return result
		}
		result++
		if sum == coins {
			return result
		}
	}
	return result
}
