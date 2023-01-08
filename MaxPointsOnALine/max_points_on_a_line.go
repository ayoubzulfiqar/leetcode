package main

func maxPoints(points [][]int) int {
	ans := 1
	n := len(points)
	for i := 0; i < n-1; i++ {
		mp := make(map[float64]int)
		for j := i + 1; j < n; j++ {
			if points[j][1] == points[i][1] {
				mp[-90]++
			} else {
				x := float64(points[j][0]-points[i][0]) / float64(points[j][1]-points[i][1])
				mp[x]++
			}
		}
		temp := 0
		for _, v := range mp {
			temp = max(temp, v+1)
		}
		ans = max(temp, ans)
	}
	return ans
}

func max(x, y int) int {
	if x > y {
		return x
	}
	return y
}
