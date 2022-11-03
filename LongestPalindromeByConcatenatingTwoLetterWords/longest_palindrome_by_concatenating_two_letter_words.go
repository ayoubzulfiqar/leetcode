package main

func longestPalindrome(words []string) int {
	freqMap := make(map[string]int)

	res := 0

	for _, word := range words {
		freqMap[word]++
	}

	for word, freq := range freqMap {
		if word[0] == word[1] {
			if freq%2 == 0 {
				res += 2 * freq
				freqMap[word] = 0
			} else {
				res += 2 * (freq - 1)
				freqMap[word] = 1
			}

			continue
		}

		reversedWord := string([]byte{word[1], word[0]})

		if reversedWordFre, ok := freqMap[reversedWord]; ok {
			m := min(freq, reversedWordFre)
			res += 4 * m

			freqMap[word] -= m
			freqMap[reversedWord] -= m
		}
	}

	for word, freq := range freqMap {
		if word[0] == word[1] && freq > 0 {
			res += 2
			break
		}
	}

	return res
}

func min(a, b int) int {
	if a < b {
		return a
	}

	return b
}
