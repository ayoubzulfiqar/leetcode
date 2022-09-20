package main

func generate(numRows int) [][]int {
	// Runtime: 0 ms, faster than 100.00% of Go online submissions for Pascal's Triangle.
	// Memory Usage: 2.1 MB, less than 55.27% of Go online submissions for Pascal's Triangle.
	ans := [][]int{{1}}

	for i := 0; i < numRows; i++ {
		v := make([]int, i+1)
		v[0] = 1
		v[i] = 1
		for j := 1; j < len(v)-1; j++ {
			v[j] = ans[i][j] + ans[i][j-1]
		}
		ans = append(ans, v)
	}
	return ans[1:]
}
