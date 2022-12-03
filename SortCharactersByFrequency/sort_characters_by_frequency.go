package main

import (
	"sort"
	"strings"
)

// func frequencySort(s string) string {
// 	l, ans := len(s), ""
// 	F, S := make([]int, 128), make([]string, l+1)
// 	for _, v := range s {
// 		F[v]++
// 	}
// 	for i, v := range F {
// 		if v != 0 {
// 			S[v] += strings.Repeat(string(rune(i)), v)
// 		}
// 	}
// 	for i := l; i > 0; i-- {
// 		if S[i] != "" {
// 			ans += S[i]
// 		}
// 	}
// 	return ans
// }

type Row struct {
	c byte
	n int
}

func frequencySort(s string) string {
	f := make([]int, 128)
	for i := 0; i < len(s); i++ {
		f[s[i]]++
	}
	var table []Row
	var res string
	for i, v := range f {
		if v != 0 {
			table = append(table, Row{byte(i), v})
		}
	}
	sort.Slice(table, func(i, j int) bool {
		return table[i].n > table[j].n
	})
	for _, v := range table {
		res += strings.Repeat(string(v.c), v.n)
		// n := v.n
		// for n != 0 {
		//     res += string(v.c)
		//     n--
		// }
	}
	return res
}
