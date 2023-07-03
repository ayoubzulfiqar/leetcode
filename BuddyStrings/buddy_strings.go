package main

func buddyStrings(s string, goal string) bool {
	n := len(s)

	if s == goal {
		temp := make(map[rune]bool)
		for _, c := range s {
			temp[c] = true
		}
		return len(temp) < len(goal) // Swapping same characters
	}

	i := 0
	j := n - 1

	for i < j && s[i] == goal[i] {
		i++
	}

	for j >= 0 && s[j] == goal[j] {
		j--
	}

	if i < j {
		sArr := []rune(s)
		temp := sArr[i]
		sArr[i] = sArr[j]
		sArr[j] = temp
		s = string(sArr)
	}

	return s == goal
}
