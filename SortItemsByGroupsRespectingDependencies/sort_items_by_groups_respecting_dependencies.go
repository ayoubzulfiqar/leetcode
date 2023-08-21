package main

func sortItems(n int, m int, group []int, beforeItems [][]int) []int {
	var ret []int
	var cnt int
	var groups = make([][]int, m)
	var checked = make([]bool, n)
	var preparing = make([]bool, n)
	var cycle = false

	for i := 0; i < m; i++ {
		groups[i] = []int{}
	}
	for i := 0; i < n; i++ {
		if group[i] != -1 {
			groups[group[i]] = append(groups[group[i]], i)
		}
	}

	var prepare func(int, bool)
	prepare = func(i int, passOn bool) {
		if preparing[i] || cycle {
			// Detecting cycle
			cycle = true
			return
		}
		preparing[i] = true

		if group[i] == -1 {
			// i belongs to no group
			for _, item := range beforeItems[i] {
				if !checked[item] {
					prepare(item, true)
				}
			}
			checked[i] = true
			ret[cnt] = i
			cnt++
		} else {
			// Prepare for other items in the same group
			for _, item := range groups[group[i]] {
				if item == i {
					continue
				}
				for _, beforeItem := range beforeItems[item] {
					if group[beforeItem] != group[item] && !checked[beforeItem] {
						prepare(beforeItem, true)
					}
				}
			}

			// Prepare and add i
			for _, item := range beforeItems[i] {
				if !checked[item] {
					prepare(item, group[item] != group[i])
				}
			}
			checked[i] = true
			ret[cnt] = i
			cnt++

			// Iterate over the whole group only the first time
			if passOn {
				for _, item := range groups[group[i]] {
					if !preparing[item] {
						prepare(item, false)
					}
				}
			}
		}
	}

	ret = make([]int, n)
	for i := 0; i < n; i++ {
		if !checked[i] {
			prepare(i, true)
		}
	}

	if cycle {
		return []int{}
	}
	return ret
}
