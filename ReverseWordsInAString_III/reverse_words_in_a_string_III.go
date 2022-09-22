package main

import "strings"

// func reverseWords(s string) string {
// 	// split by space
// 	w := strings.Split(s, " ")
// 	// iterate each word
// 	for k, v := range w {
// 		// convert to bytes array
// 		b := []byte(v)
// 		// length of current word
// 		n := len(v)
// 		// for each word, we iterate n / 2 times
// 		for i := 0; i < n/2; i++ {
// 			// swap the characters
// 			b[i], b[n-1-i] = b[n-1-i], b[i]
// 			// w[k] here is the reversed version of v
// 			w[k] = string(b)
// 		}
// 	}
// 	// build the final string
// 	return strings.Join(w, " ")
// }

func reverseWords(s string) string {
	byteArr := []byte(s)
	low, high := 0, len(byteArr)-1
	for low < high {
		tmp := byteArr[low]
		byteArr[low] = byteArr[high]
		byteArr[high] = tmp
		low++
		high--
	}

	arr := strings.Split(string(byteArr), " ")

	l, h := 0, len(arr)-1
	for l < h {
		t := arr[l]
		arr[l] = arr[h]
		arr[h] = t
		l++
		h--
	}

	return strings.Join(arr, " ")
}
