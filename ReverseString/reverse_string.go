package main

func reverseString(s []byte) {
	l, r := 0, len(s)-1
	for i := 0; i < len(s)/2; i++ {
		l = i
		r = len(s) - (i + 1)
		s[l], s[r] = s[r], s[l]
	}
}
