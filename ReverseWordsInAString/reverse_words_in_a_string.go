package main

import "strings"

func reverseWords(s string) string {
	var ans strings.Builder

	p1, p2 := len(s), len(s)

	for p1 >= 0 {
		p1--

		if p1 >= 0 && s[p1] != ' ' {
			continue
		}

		if p1+1 == p2 { //to remove any trailing white spaces
			p2 = p1
			continue
		}

		if len(ans.String()) > 0 { // to add spaces between words but after the first word
			ans.WriteString(" ")
		}

		ans.WriteString(s[p1+1 : p2])
		p2 = p1
	}

	return ans.String()
}
