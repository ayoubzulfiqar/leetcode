package main

func maxLength(arr []string) int {
	st := make([]int, 0, len(arr))
	for i := range arr {
		s := 0
		f := true
		for j := range arr[i] {
			b := 1 << (arr[i][j] - 97)
			if b&s != 0 {
				f = false
				break
			}
			s |= b
		}
		if f {
			st = append(st, s)
		}
	}

	r := -1
	var f func(int, int)
	f = func(i, s int) {
		cnt := 0
		ds := s
		for ds > 0 {
			cnt += ds & 1
			ds = ds >> 1
		}
		if cnt > r {
			r = cnt
		}
		if i >= len(st) {
			return
		}
		for j := i + 1; j < len(st); j++ {
			if s&st[j] == 0 {
				f(j, s|st[j])
			}
		}
	}
	f(-1, 0)
	return r
}

/*



func maxLength(arr []string) int {
    masks := make([]int, len(arr))
    for i, s := range arr {
        masks[i] = createMask(s)
    }

    maxLen := 0
    for i := 0; i < len(arr); i++ {
        maxLen = max(maxLen, dp(arr, masks, 0, 0, map[int]int{}))
    }

    return maxLen
}

func dp(arr []string, masks []int, curMask int, pos int, memo map[int]int) int {
    if pos == len(arr) {
        return 0
    }
    memoKey := (curMask << 32) | pos
    if memo[memoKey] > 0 {
        return memo[memoKey]
    }
    maxLen := dp(arr, masks, curMask, pos + 1, memo) // ignoring arr[pos] word
    if masks[pos] != 0 && (curMask & masks[pos]) == 0 {
        maxLen = max(
            maxLen,
            len(arr[pos]) + dp(arr, masks, curMask | masks[pos], pos + 1, memo),
        )
    }
    memo[memoKey] = maxLen
    return maxLen
}

func createMask(s string) int {
    mask := 0
    for _, b := range s {
        add := 1 << (b - 'a')
        if (mask & add) == add {
            return 0 // duplicate byte (char)
        }
        mask |= add
    }
    return mask
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}



*/
