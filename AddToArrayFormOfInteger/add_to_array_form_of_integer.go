package main

func addToArrayForm(num []int, k int) []int {
	res := []int{}
	size := len(num) - 1
	for size >= 0 || k > 0 {
		if size >= 0 {
			k += num[size]
			size--
		}
		res = append([]int{k % 10}, res...)
		k /= 10
	}
	return res
}
