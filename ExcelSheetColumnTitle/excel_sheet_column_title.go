package main

import "fmt"

// func convertToTitle(n int) string {
// 	result := ""
// 	for n != 0 {
// 		fmt.Println(n)
// 		result = string('A'+(n-1)%26) + result
// 		n = (n - 1) / 26
// 	}
// 	return result
// }

func convertToTitle(n int) string {
	result := ""
	for n != 0 {
		fmt.Println(n)
		result = string(rune('A'+(n-1)%26)) + result
		n = (n - 1) / 26
	}
	return result
}
