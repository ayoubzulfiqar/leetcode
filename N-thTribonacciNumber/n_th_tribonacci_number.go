package main

// func tribonacci(n int) int {
// 	if n == 0 {
// 		return 0
// 	}
// 	if n == 1 || n == 2 {
// 		return 1
// 	}
// 	var Tribonacci []int = make([]int, n+1)
// 	Tribonacci[0] = 0
// 	Tribonacci[1] = 1
// 	Tribonacci[2] = 1
// 	for i := 3; i < n+1; i++ {
// 		Tribonacci[i] = Tribonacci[i-1] + Tribonacci[i-2] + Tribonacci[i-3]
// 	}
// 	return Tribonacci[n]
// }

// func tribonacci(n int) int {
// if n == 0 {
// 	return 0
// }
// if n == 1 || n == 2 {
// 	return 1
// }

// 	var a int = 0
// 	var b int = 1
// 	var c int = 1
// 	var d int = 0
// 	for i := 3; i <= n; i++ {
// 		d = a + b + c
// 		a = b
// 		b = c
// 		c = d
// 	}
// 	return d
// }

func tribonacci(n int) int {
	if n == 0 {
		return 0
	}
	if n == 1 || n == 2 {
		return 1
	}
	return tribonacci(n-1) + tribonacci(n-2) + tribonacci(n-3)
}
