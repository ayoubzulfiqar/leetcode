package main

// func climbStairs(n int) int {
// 	if n == 0 || n == 1 || n == 2 || n == 3 {
// 		return n
// 	}
// 	var sum int = 0
// 	var left int = 1
// 	var right int = 1
// 	for i := 2; i < n; i++ {
// 		sum = left + right
// 		left = right
// 		right = sum
// 	}
// 	return sum
// }

func climbStairs(n int) int {
	var one int = 1
	var two int = 0
	for i := 2; i <= n; i++ {
		var temp int = one
		one += two
		two = temp
	}
	return one
}
