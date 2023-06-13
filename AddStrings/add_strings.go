package main

import (
	"strconv"
	"strings"
)

func addStrings(num1 string, num2 string) string {
	var sb strings.Builder

	i, j := len(num1)-1, len(num2)-1
	carry := 0

	for i >= 0 || j >= 0 {
		sum := carry

		if i >= 0 {
			digit, _ := strconv.Atoi(string(num1[i]))
			sum += digit
			i--
		}
		if j >= 0 {
			digit, _ := strconv.Atoi(string(num2[j]))
			sum += digit
			j--
		}

		sb.WriteString(strconv.Itoa(sum % 10))
		carry = sum / 10
	}

	if carry != 0 {
		sb.WriteString(strconv.Itoa(carry))
	}

	result := sb.String()
	reversedResult := reverseString(result)
	return reversedResult
}

func reverseString(s string) string {
	runes := []rune(s)
	for i, j := 0, len(runes)-1; i < j; i, j = i+1, j-1 {
		runes[i], runes[j] = runes[j], runes[i]
	}
	return string(runes)
}
