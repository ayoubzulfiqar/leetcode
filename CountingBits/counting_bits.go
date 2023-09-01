package main

// func countBits(n int) []int {
// 	arr := make([]int, n+1)
// 	arr[0] = 0
// 	prevPow := 1
// 	for i := 1; i <= n; i++ {
// 		if i&(i-1) == 0 {
// 			arr[i] = 1
// 			prevPow = i
// 			continue
// 		}
// 		arr[i] = 1 + arr[i-prevPow]
// 	}
// 	return arr
// }

func countBits(n int) []int {
	var array []int = make([]int, n+1)
	for i := 1; i <= n; i++ {
		array[i] = array[i>>1] + (i & 1)
	}
	return array
}
