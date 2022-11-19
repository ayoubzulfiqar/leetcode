package main

import "sync"

func findTheDifference(s string, t string) (res byte) {
	originalChars, newChars := make(map[byte]int), make(map[byte]int)

	stringToMap := func(str string) map[byte]int {
		m := make(map[byte]int)
		for i := 0; i < len(str); i++ {
			if _, found := m[str[i]]; found {
				m[str[i]]++
			} else {
				m[str[i]] = 1
			}
		}
		return m
	}

	var wg sync.WaitGroup
	wg.Add(2)
	go func() {
		defer wg.Done()
		originalChars = stringToMap(s)
	}()
	go func() {
		defer wg.Done()
		newChars = stringToMap(t)
	}()

	wg.Wait()

	for char, newCount := range newChars {
		if originalCount, found := originalChars[char]; found {
			if newCount != originalCount {
				return char
			}
		} else {
			return char
		}
	}

	return
}

//Using XOR

// Accepted, Runtime: 0 ms, Memory Usage: 2.1 MB
// Runtime: 0 ms, faster than 100.00% of Go online submissions for Find the Difference.
// func findTheDifference(s string, t string) (res byte) {
// 	var wg sync.WaitGroup
// 	wg.Add(2)
// 	go func() {
// 		defer wg.Done()
// 		for i := 0; i < len(s); i++ {
// 			res ^= s[i]
// 		}
// 	}()
// 	go func() {
// 		defer wg.Done()
// 		for i := 0; i < len(t); i++ {
// 			res ^= t[i]
// 		}
// 	}()
// 	wg.Wait()
// 	return
// }
