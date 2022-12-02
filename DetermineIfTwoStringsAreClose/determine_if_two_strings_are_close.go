package main

func closeStrings(word1 string, word2 string) bool {
	var ctr1, ctr2 [26]int

	if len(word1) != len(word2) {
		return false
	}
	for i := 0; i < len(word1); i++ {
		ctr1[word1[i]-byte('a')]++
		ctr2[word2[i]-byte('a')]++
	}
	for i := 0; i < len(ctr1); i++ {
		if (ctr1[i] != 0) != (ctr2[i] != 0) {
			return false
		}
	}
	cctr := make(map[int]int)
	for i := 0; i < len(ctr1); i++ {
		cctr[ctr1[i]]++
		cctr[ctr2[i]]--
	}
	for _, c := range cctr {
		if c != 0 {
			return false
		}
	}
	return true
}
