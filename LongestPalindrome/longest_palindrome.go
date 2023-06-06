package main

func longestPalindrome1(s string) int {
	frequency := make(map[string]int)
	length := 0

	// Count the frequency of each letter
	for i := 0; i < len(s); i++ {
		char := string(s[i])
		frequency[char] = frequency[char] + 1
	}

	// Iterate through the frequency counts
	for _, count := range frequency {
		if count%2 == 0 {
			length += count
		} else {
			length += count - 1
		}
	}

	// Check for remaining letters with odd counts
	if length < len(s) {
		length += 1
	}

	return length
}

// type Solution struct{}

func longestPalindrome(str string) int {
	count := make([]int, 256)
	odds := 0

	for _, char := range str {
		count[char]++
		if count[char]&1 == 1 {
			odds++
		} else {
			odds--
		}
	}

	return len(str) - odds + boolToInt(odds > 0)
}

func boolToInt(b bool) int {
	if b {
		return 1
	}
	return 0
}
