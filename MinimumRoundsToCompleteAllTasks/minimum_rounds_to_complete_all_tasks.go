// package main

// var mem = map[int]int{}

// func steps(n int) int {
// 	if n <= 1 {
// 		return -1
// 	}
// 	if ret, ok := mem[n]; ok {
// 		return ret
// 	}
// 	if n == 2 {
// 		return 1
// 	}
// 	if n%3 == 0 {
// 		mem[n] = n / 3
// 		return n / 3
// 	}
// 	out := 1 + steps(n-2)
// 	mem[n] = out
// 	return out
// }

// func minimumRounds(tasks []int) int {
// 	dic := map[int]int{}
// 	for _, t := range tasks {
// 		dic[t]++
// 	}
// 	out := 0
// 	for _, n := range dic {
// 		s := steps(n)
// 		if s == -1 {
// 			return -1
// 		}
// 		out += s
// 	}
// 	return out
// }

package main

import "sort"

func minimumRounds(tasks []int) int {
	sort.Ints(tasks)
	var result int = 0
	for i := 0; i < len(tasks); i++ {
		var j int = i + 1
		for j < len(tasks) && tasks[j] == tasks[i] {
			j++
			if j == i+1 {
				return -1
			}
		}

		result += (j - i + 2) / 3
		i = j
	}
	return result
}

/*


int minimumRounds(List<int> tasks) {
  tasks.sort();
  int res = 0;
  for (int i = 0; i < tasks.length;) {
    int j = i + 1;
    while (j < tasks.length && tasks[j] == tasks[i]) j++;
    if (j == i + 1) return -1;
    res += (j - i + 2) ~/ 3;
    i = j;
  }
  return res;
}
*/
