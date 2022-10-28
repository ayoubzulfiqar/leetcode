package main

import "bytes"

func groupAnagrams(strs []string) [][]string {
	alphaBits := make(map[string][]string, 0)
	for _, str := range strs {
		idx := getAlphabetBit(str)
		alphaBits[idx] = append(alphaBits[idx], str)
	}

	var res = make([][]string, len(alphaBits))
	var i = 0
	for _, strs := range alphaBits {
		res[i] = strs
		i += 1
	}
	return res
}

func getAlphabetBit(str string) string {
	res := make([]int, 26)
	for _, ch := range str {
		chInt := int(ch - 'a')
		res[chInt] += 1
	}
	var b bytes.Buffer
	for _, bit := range res {
		b.WriteByte(byte(int('0') + bit))
	}
	return b.String()
}
