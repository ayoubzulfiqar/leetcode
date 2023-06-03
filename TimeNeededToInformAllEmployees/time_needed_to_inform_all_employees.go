package main

import (
	"container/list"
)

type Pair struct {
	key   int
	value int
}

func numOfMinutes(n int, headID int, manager []int, informTime []int) int {
	arr := make([][]int, n)
	for i := 0; i < n; i++ {
		arr[i] = make([]int, 0)
	}

	for i := 0; i < n; i++ {
		if manager[i] != -1 {
			arr[manager[i]] = append(arr[manager[i]], i)
		}
	}

	q := list.New()
	q.PushBack(Pair{key: headID, value: informTime[headID]})
	ans := 0

	for q.Len() > 0 {
		si := q.Len()

		for i := 0; i < si; i++ {
			t := q.Remove(q.Front()).(Pair)

			for _, x := range arr[t.key] {
				if informTime[x] == 0 {
					if ans < t.value {
						ans = t.value
					}
				} else {
					q.PushBack(Pair{key: x, value: t.value + informTime[x]})
				}
			}
		}
	}

	return ans
}
