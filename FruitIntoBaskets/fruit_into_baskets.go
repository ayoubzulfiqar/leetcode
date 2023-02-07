package main

func totalFruit(f []int) int {
	if len(f) == 0 {
		return 0
	}

	if len(f) == 1 {
		return 1
	}

	res := -1 << 63

	m := make(map[int]int)

	l := 0
	m[f[l]]++

	for i := 1; i < len(f); i++ {
		m[f[i]]++

		for len(m) > 2 {
			m[f[l]]--

			if m[f[l]] == 0 {
				delete(m, f[l])
			}

			l++
		}

		if i-l+1 > res {
			res = i - l + 1
		}
	}

	return res
}
