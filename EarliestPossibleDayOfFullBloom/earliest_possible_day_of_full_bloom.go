package main

import "sort"

func earliestFullBloom(plantTime []int, growTime []int) int {
	t := times{plantTime, growTime}
	sort.Sort(t)

	res, curDay := 0, 0
	for i := range plantTime {
		res = max(res, curDay+plantTime[i]+growTime[i])
		curDay += plantTime[i]
	}

	return res
}

type times struct {
	grow, plant []int
}

func (t times) Len() int           { return len(t.plant) }
func (t times) Less(i, j int) bool { return t.plant[i] > t.plant[j] }
func (t times) Swap(i, j int) {
	t.plant[i], t.plant[j] = t.plant[j], t.plant[i]
	t.grow[i], t.grow[j] = t.grow[j], t.grow[i]
}

func max(a, b int) int {
	if a > b {
		return a
	}

	return b
}
