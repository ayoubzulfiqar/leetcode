package main

import "strings"

// 1. using strings' build-in func
func detectCapitalUse(word string) bool {
	return word == strings.ToLower(word) || word == strings.ToUpper(word) || word == strings.Title(strings.ToLower(word))
}

// 2. set condition for judging
func isCapital(letter int32) bool {
	return letter <= 'Z' && letter >= 'A'
}

/*
func detectCapitalUse(word string) bool {
	var condition = 0

	for index, letter := range word {
		switch isCapital(letter) {
		case true:
			if condition == 0 {
				condition = 1
				continue
			} else if condition == 1 {
				continue
			} else if condition == 2 || condition == 3 {
				return false
			}
		case false:
			if condition == 0 {
				condition = 2
			} else if condition == 1{
				if index == 1 {
					condition = 3
				} else {
					return false
				}
			} else if condition == 2 || condition == 3{
				continue
			}
		}
	}

	return true
}

*/
