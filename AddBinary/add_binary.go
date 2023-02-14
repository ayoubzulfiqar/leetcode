package main

import "strings"

func addBinary(a string, b string) string {
	memory := false
	if len(b) < len(a) {
		a, b = b, a
	}
	m := len(a)
	n := len(b)

	answer := []string{}

	for i := m - 1; i >= 0; i-- {
		x := string(a[i])
		y := string(b[(n-m)+i])

		if x == "1" && y == "1" {
			if memory {
				answer = append(answer, "1")
			} else {
				answer = append(answer, "0")
				memory = true
			}
		} else if x == "1" || y == "1" {
			if memory {
				answer = append(answer, "0")
			} else {
				answer = append(answer, "1")
			}
		} else {
			if memory {
				answer = append(answer, "1")
				memory = false
			} else {
				answer = append(answer, "0")
			}
		}
	}

	for i := n - m - 1; i >= 0; i-- {
		x := string(b[i])
		if x == "1" {
			if memory {
				answer = append(answer, "0")
			} else {
				answer = append(answer, "1")
			}
		} else if x == "0" {
			if memory {
				answer = append(answer, "1")
				memory = false
			} else {
				answer = append(answer, "0")
			}
		}
	}

	if memory {
		answer = append(answer, "1")
	}

	return strings.Join(reverse(answer), "")
}

func reverse(array []string) []string {
	left := 0
	right := len(array) - 1
	for left < right {
		array[left], array[right] = array[right], array[left]
		left++
		right--
	}
	return array
}
