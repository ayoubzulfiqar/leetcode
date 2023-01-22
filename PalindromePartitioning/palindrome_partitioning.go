package main

func partition(s string) [][]string {
	result := [][]string{}
	seq := make([]string, 0, len(s))
	dfs(s, &result, seq)
	return result
}

func dfs(s string, result *[][]string, seq []string) {
	if len(s) == 0 {
		cp := make([]string, len(seq))
		copy(cp, seq)
		*result = append(*result, cp)
		return
	}

	for i := 1; i <= len(s); i++ {
		subStr := s[:i]
		if isPalindrome(subStr) {
			dfs(s[i:], result, append(seq, subStr))
		}
	}
}

func isPalindrome(s string) bool {
	l, r := 0, len(s)-1
	for l < r {
		if s[l] != s[r] {
			return false
		}
		l++
		r--
	}
	return true
}
