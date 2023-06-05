package main

func getRow(r int) []int {
	var ans []int = make([]int, r+1)
	ans[0] = 1
	ans[r] = 1
	for i := 1; i <= r; i++ {
		ans[i] = ans[i-1] * (r - i + 1) / i
	}
	return ans
}
