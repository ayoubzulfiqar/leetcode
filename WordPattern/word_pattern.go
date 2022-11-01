package main

import "strings"

func wordPattern(pattern string, s string) bool {
	words := strings.Split(s, " ")
	if len(words) != len(pattern) {
		return false
	}
	hashMap := make(map[interface{}]int)
	for i, word := range words {
		if hashMap[word] != hashMap[pattern[i]] {
			return false
		}
		hashMap[word] = i + 1
		hashMap[pattern[i]] = i + 1
	}
	return true
}
