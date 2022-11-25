package main

func sumSubarrayMins(arr []int) int {
	arr = append(arr, 0)
	stack, res, j := []int{-1}, 0, 0
	for i, n := range arr {
		for len(stack) > 1 && arr[stack[len(stack)-1]] > n {
			j, stack = stack[len(stack)-1], stack[:len(stack)-1]
			res += (j - stack[len(stack)-1]) * (i - j) * arr[j]
			res %= 1_000_000_007
		}
		stack = append(stack, i)
	}
	return res
}
