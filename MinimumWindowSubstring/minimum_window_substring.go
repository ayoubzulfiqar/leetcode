package main

func minWindow(s string, t string) string {
	rem := 0
	counter := make(map[byte]int)
	for i := range t {
		rem++
		counter[t[i]]++
	}
	if rem > len(s) {
		return ""
	}
	var ret = string(make([]byte, len(s)))
	start, end := 0, 0
	for end < len(s) {
		if v, ok := counter[s[end]]; ok {
			if v > 0 {
				rem--
			}
			counter[s[end]]--
		}
		for rem <= 0 {
			if len(ret) >= len(s[start:end+1]) {
				ret = s[start : end+1]
			}
			if _, ok := counter[s[start]]; ok {
				counter[s[start]]++
				if counter[s[start]] > 0 {
					rem++
				}
			}
			start++
		}
		end++
	}

	if ret == string(make([]byte, len(s))) {
		return ""
	}
	return ret
}
