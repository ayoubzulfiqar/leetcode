package main

func isPalindrome(s string) bool {
	isD := func(r rune) bool {
		return r >= '0' && r <= '9'
	}
	isA := func(r rune) bool {
		return (r >= 'a' && r <= 'z') || (r >= 'A' && r <= 'Z')
	}
	is := func(r rune) bool {
		return isA(r) || isD(r)
	}

	l := len(s)
	lt := 0
	rt := l - 1
	var empty rune
	for lt < rt {
		var f rune
		var l rune
		for lt < rt {
			if is(rune(s[lt])) {
				f = rune(s[lt])
				break
			}
			lt++
		}
		for lt < rt {
			if is(rune(s[rt])) {
				l = rune(s[rt])
				break
			}
			rt--
		}
		switch {
		case isA(f) && isD(l) || isD(f) && isA(l):
			return false
		case !(f-l == 32 || f-l == -32 || f-l == 0) && f != empty && l != empty:
			return false
		}
		lt++
		rt--
	}
	return true
}

func isPalindromes(s string) bool {
	result := ""
	for i := 0; i < len(s); i++ {
		if isAlphaNumeric(string(s[i])) {
			if isNum(string(s[i])) {
				result += string(s[i])
			}
			if isUpperCase(string(s[i])) {
				result += string(lowerCase(string(s[i])))
			} else {
				result += string(s[i])
			}
		}
	}
	return palindrom(string(result))
}

func isAlphaNumeric(s string) bool {
	if ('0' <= s[0] && s[0] <= '9') || (s[0] >= 'a' && s[0] <= 'z') || (s[0] >= 'A' && s[0] <= 'Z') {
		return true
	}
	return false
}

func isUpperCase(s string) bool {
	if s[0] >= 'A' && s[0] <= 'Z' {
		return true
	}
	return false
}

func isNum(s string) bool {
	if s[0] >= '0' && s[0] <= '9' {
		return true
	}
	return false
}

func lowerCase(s string) byte {
	return s[0] - 'A' + 'a'
}

func palindrom(s string) bool {
	for i := 0; i < len(s)/2; i++ {
		if s[i] != s[len(s)-1-i] {
			return false
		}
	}
	return true
}
