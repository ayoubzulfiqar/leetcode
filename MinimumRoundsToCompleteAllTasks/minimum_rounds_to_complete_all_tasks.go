package main

var mem = map[int]int{}

func steps(n int) int {
	if n <= 1 {
		return -1
	}
	if ret, ok := mem[n]; ok {
		return ret
	}
	if n == 2 {
		return 1
	}
	if n%3 == 0 {
		mem[n] = n / 3
		return n / 3
	}
	out := 1 + steps(n-2)
	mem[n] = out
	return out
}

func minimumRounds(tasks []int) int {
	dic := map[int]int{}
	for _, t := range tasks {
		dic[t]++
	}
	out := 0
	for _, n := range dic {
		s := steps(n)
		if s == -1 {
			return -1
		}
		out += s
	}
	return out
}
