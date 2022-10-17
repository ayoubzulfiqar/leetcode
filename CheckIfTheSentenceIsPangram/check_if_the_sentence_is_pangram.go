package main

func checkIfPangram(sentence string) bool {
	var indices [26]int
	var sumIndices int
	for i := 0; i < len(sentence); i++ {
		indices[sentence[i]-97] = 1
	}
	for i := 0; i < len(indices); i++ {
		sumIndices += indices[i]
	}
	return sumIndices == 26
}
