package main

func distinctNames(ideas []string) int64 {
	count := make(map[rune]map[string]bool)
	for _, a := range ideas {
		firstLetter := []rune(a)[0]
		if _, ok := count[firstLetter]; !ok {
			count[firstLetter] = make(map[string]bool)
		}
		count[firstLetter][a[1:]] = true
	}
	res := 0
	for a, seta := range count {
		for b, setB := range count {
			if a >= b {
				continue
			}
			same := 0
			for s := range seta {
				if setB[s] {
					same++
				}
			}
			res += (len(seta) - same) * (len(setB) - same)
		}
	}
	return int64(res * 2)
}
