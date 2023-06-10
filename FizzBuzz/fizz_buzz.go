package main

import "fmt"

func fizzBuzz(n int) []string {
	var answer []string
	for index := 1; index <= n; index++ {
		if index%3 == 0 && index%5 == 0 {
			answer = append(answer, "FizzBuzz")
		} else if index%3 == 0 {
			answer = append(answer, "Fizz")
		} else if index%5 == 0 {
			answer = append(answer, "Buzz")
		} else {
			str := fmt.Sprintf("%d", index)
			answer = append(answer, str)
		}
	}
	return answer
}

func fizzBuzz2(n int) []string {
	answer := make([]string, 0, n)
	for index := 1; index <= n; index++ {
		switch index % 15 {
		case 0:
			answer = append(answer, "FizzBuzz")
		case 3, 6, 9, 12:
			answer = append(answer, "Fizz")
		case 5, 10:
			answer = append(answer, "Buzz")
		default:
			answer = append(answer, fmt.Sprintf("%d", index))
		}
	}
	return answer
}
