package main

func canConstruct(ransomNote string, magazine string) bool {
	if len(ransomNote) > len(magazine) {
		return false
	}
	var freqMap [26]int

	for _, char := range magazine {
		freqMap[char-'a']++
	}

	for _, char := range ransomNote {
		freqMap[char-'a']--

		if freqMap[char-'a'] < 0 {
			return false
		}
	}

	return true
}
