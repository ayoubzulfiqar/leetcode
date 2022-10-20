package main

import "strings"

type tuple struct {
	char string
	val  int
}

func intToRoman(num int) string {

	//Step1: Store roman characters along with the corresponding value in decreasing order of the integer value
	slice := make([]tuple, 13)
	slice[0] = tuple{"M", 1000}
	slice[1] = tuple{"CM", 900}
	slice[2] = tuple{"D", 500}
	slice[3] = tuple{"CD", 400}
	slice[4] = tuple{"C", 100}
	slice[5] = tuple{"XC", 90}
	slice[6] = tuple{"L", 50}
	slice[7] = tuple{"XL", 40}
	slice[8] = tuple{"X", 10}
	slice[9] = tuple{"IX", 9}
	slice[10] = tuple{"V", 5}
	slice[11] = tuple{"IV", 4}
	slice[12] = tuple{"I", 1}

	var res strings.Builder
	//Step2: Loop through the slice, and divide the number to get the count.
	//Repeat the corresponding roman character by count in the result string.
	//Take the remainder and repeat the loop
	for i := 0; i < 13; i++ {
		count := num / slice[i].val
		if count > 0 {
			str := strings.Repeat(slice[i].char, count)
			res.WriteString(str)
		}
		num = num % slice[i].val
		//Optimization: once num becomes 0, break out of the loop
		if num == 0 {
			break
		}
	}

	return res.String()
}
