package main

func dailyTemperatures(temperatures []int) []int {
	var res []int = make([]int, len(temperatures))
	for i := len(temperatures) - 2; i >= 0; i-- {
		var next int = i + 1
		for next < len(temperatures) && temperatures[next] <= temperatures[i] {
			if res[next] == 0 {
				next = len(temperatures)
				break
			}
			next += res[next]
		}
		if next < len(temperatures) {
			res[i] = next - i
		}
	}
	return res
}
